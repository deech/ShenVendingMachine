(load "cl-wrappers.shen")

(package nativeCalls (append (external cl-wrapper)
			     [open-socket start-server stop-server])
(set *my-server* nil)
(set *connectionStore* [])
(set *mailbox* (((protect READ-FROM-STRING) "SB-CONCURRENCY::MAKE-MAILBOX")))
(declare open-socket [string --> [number --> symbol]])
(declare start-server [symbol --> symbol])
(declare stop-server [--> unit])
(declare get-server [--> symbol])

(define open-socket
  Host Port -> (set *my-server* (socket-listen Host Port)))
(define start-server
  Sock -> (let accepted (socket-accept Sock)
	    (set *connectionStore* (append [accepted]
					   (value *connectionStore*)))))
(define stop-server
  -> (do (map (function socket-close) (value *connectionStore*))
	 (socket-close (get-server))))
(define get-server -> (value *my-server*)))
