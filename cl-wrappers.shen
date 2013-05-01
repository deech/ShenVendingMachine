(load "native-calls.shen")
(load-lisp "/home/deech/Lisp/shenScripts/VendingMachine/cl-libs.lsp")
(package cl-wrapper [*mailbox* socket-listen socket-accept socket-close pass-on-input connection-name make-thread kill-thread send-message receive-message]
(declare socket-listen [string --> [number --> server]])
(declare socket-accept [server --> unit])
(declare socket-close [server --> unit])
(define socket-listen
  Host Port -> (((protect READ-FROM-STRING) "USOCKET::SOCKET-LISTEN")
		Host
		Port))
(define connection-name
  Connection -> (((protect READ-FROM-STRING) "USOCKET::GET-PEER-NAME")
		Connection))
(define socket-accept
  Sock -> (((protect READ-FROM-STRING) "USOCKET::SOCKET-ACCEPT")
	   Sock))
(define socket-close
  Sock -> (trap-error
		(((protect READ-FROM-STRING) "USOCKET::SOCKET-CLOSE") Sock)
		(/. E (output "~A" E))))
(define write-to-stream
  Stream Response -> (do ((protect WRITE-LINE) "==Response==" Stream)
		         ((protect WRITE-LINE) Response Stream)
			 ((protect WRITE-LINE) "============" Stream)
			 ((protect FORCE-OUTPUT) Stream)))
(define read-line
  Stream -> ((protect READ-LINE) Stream NIL NIL))
(define wait-for-input
  Connection F UserState Continue? -> Continue? where (= Continue? (protect Done))
  Connection F UserState Continue? ->
      (let Ready (((protect READ-FROM-STRING) "USOCKET::WAIT-FOR-INPUT") Connection)
	   Stream (((protect READ-FROM-STRING) "USOCKET::SOCKET-STREAM") Ready)
	   Line  (read-line Stream)
	(if (= Line NIL)
	    (wait-for-input Connection F UserState (protect Done))
	    (wait-for-input-h (F (receive-message (value *mailbox*)) Line UserState)
		              Stream
			      (value *mailbox*)
			      (/. NewUserState (wait-for-input Connection F NewUserState (protect Continue))))))
      where (= Continue? (protect Continue)))
(define wait-for-input-h
  (@p UserResponse NewVendingMachine NewUserState) Stream Mailbox RecursiveCall
    -> (do (write-to-stream Stream UserResponse)
	   (send-message Mailbox NewVendingMachine)
	   (RecursiveCall NewUserState)))
(define send-response
  (@p UserResponse NewVendingMachine) Stream Mailbox
       -> (do (write-to-stream Stream UserResponse)
	      (send-message Mailbox NewVendingMachine)))
(define kill-thread
  Thread -> (trap-error (((protect READ-FROM-STRING) "SB-THREAD::TERMINATE-THREAD") Thread)
		        (/. E (output "~A" E))))
(define interrupt-thread
  Thread F -> (((protect READ-FROM-STRING) "SB-THREAD::INTERRUPT-THREAD") F Thread))
(define make-thread
  F -> (((protect READ-FROM-STRING) "SB-THREAD::MAKE-THREAD") F))
(define pass-on-input
  Connection F UserState ->
      (make-thread
	 (freeze (do (wait-for-input Connection F UserState (protect Continue))
		     (socket-close Connection)))))
(define receive-message
  Mailbox -> (((protect READ-FROM-STRING) "SB-CONCURRENCY::RECEIVE-MESSAGE") Mailbox))
(define send-message
  Mailbox Message -> (((protect READ-FROM-STRING) "SB-CONCURRENCY::SEND-MESSAGE") Mailbox Message))
)
