(load "native-calls.shen")
(load-lisp "server.lsp")

(package nativeCalls [get-server]
(set *my-server* nil)
(set *connectionStore* [])
(set *mailbox* (((protect READ-FROM-STRING) "SB-CONCURRENCY::MAKE-MAILBOX")))
(define open-socket
  Host Port -> (set *my-server* (((protect READ-FROM-STRING) "USOCKET::SOCKET-LISTEN") Host Port)))
(define start-server
  Sock -> (let accepted (((protect READ-FROM-STRING) "USOCKET::SOCKET-ACCEPT") Sock)
	    (do  (set *connectionStore* (append [accepted] (value *connectionStore*)))
		 (((protect READ-FROM-STRING) "SB-CONCURRENCY::SEND-MESSAGE")
		  (value *mailbox*)
		  (protect NewClient)))))
(define stop-server
  -> (do (map (function ((protect READ-FROM-STRING) "USOCKET::SOCKET-CLOSE"))
	      (value *connectionStore*))
	 (((protect READ-FROM-STRING) "USOCKET::SOCKET-CLOSE") (value *my-server*))))
(define get-server -> (value *my-server*))
)
