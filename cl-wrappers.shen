(load "native-calls.shen")
(load-lisp "server.lsp")
(package cl-wrapper [socket-listen socket-accept socket-close]
(declare socket-listen [string --> [number --> symbol]])
(declare socket-accept [symbol --> unit])
(declare socket-close [symbol --> unit])
(define socket-listen
  Host Port -> (((protect READ-FROM-STRING) "USOCKET::SOCKET-LISTEN")
		Host
		Port))
(define socket-accept
  Sock -> (((protect READ-FROM-STRING) "USOCKET::SOCKET-ACCEPT")
	   Sock))
(define socket-close
  Sock -> (((protect READ-FROM-STRING) "USOCKET::SOCKET-CLOSE") Sock))
)
