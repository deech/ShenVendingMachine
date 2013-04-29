\*
(defun receive-each (connections)
  (let ((ready (usocket:wait-for-input connections :timeout 0 :ready-only t)))
    (loop for connection in ready
       collect (read-line (usocket:socket-stream connection)))))
*\
(load "native-calls.shen")
(load-lisp "cl-libs.lsp")
(package cl-wrapper [socket-listen socket-accept socket-close pass-on-input connection-name make-thread kill-thread]
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
  Stream Response -> (do ((protect WRITE-LINE) Response Stream)
			 ((protect FORCE-OUTPUT) Stream)
			 ))

(define read-line
  Stream -> ((protect READ-LINE) Stream NIL NIL))
(define wait-for-input
  Connection F Continue? -> Continue? where (= Continue? (protect Done))
  Connection F Continue? ->
      (let Ready (((protect READ-FROM-STRING) "USOCKET::WAIT-FOR-INPUT") Connection)
	   Stream (((protect READ-FROM-STRING) "USOCKET::SOCKET-STREAM") Ready)
	   Line  (read-line Stream)
	(if (= Line NIL)
	    (wait-for-input Connection F (protect Done))
	    (do (write-to-stream Stream (F Line))
		(wait-for-input Connection F (protect Continue)))))
      where (= Continue? (protect Continue)))
(define kill-thread
  Thread -> (trap-error (((protect READ-FROM-STRING) "SB-THREAD::TERMINATE-THREAD") Thread)
		        (/. E (output "~A" E))))
(define make-thread
  F -> (((protect READ-FROM-STRING) "SB-THREAD::MAKE-THREAD") F))
(define pass-on-input
  Connection F ->
      (make-thread
	 (freeze (do (wait-for-input Connection F (protect Continue))
		     (output "~A" "about to close connection")
		     (socket-close Connection)))))
)
