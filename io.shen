(declare open-socket [ip-address --> [number --> socket]])
(declare accept-connection [socket --> unit])
(declare stop-server [--> unit])
(declare get-server [--> socket])
(declare is-ip-address [string --> boolean])

(define open-socket
  Host Port -> (let Sock (socket-listen Host Port)
		 (do (add-to *connectionStore* Sock)
		     Sock)))

(define accept-connection
  Sock -> (let Accepted (socket-accept Sock)
            (do (add-to *connectionStore* Accepted)
		(add-to *thread-store* (pass-on-input
					     Accepted
					     (/. VendingMachine Line UserState
						 (trap-error
						       (let Command (parse-command-line Line)
							 (process-request
								  VendingMachine
								  Command
								  UserState))
						       (/. E (@p (error-to-string E)
								 VendingMachine
								 UserState))))
					     (empty-state)))
		(accept-connection Sock))))

(define stop-server
  -> (do (map (function socket-close) (value *connectionStore*))
	 (map (function kill-thread) (value *thread-store*))))

(define get-server
  -> (value *my-server*))

(define is-ip-address
  X -> (or (not (= (trap-error
                         (compile
                           (function <ip-address>)
                           (map (function string->n)
                                 (explode X)))
                         (/. E (fail)))
                   (fail)))
	   (= X "localhost")))
