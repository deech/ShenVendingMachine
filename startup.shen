(include-all-but [buy-type currency-type candy-type])
(define startup
  {ip-address --> socket}
  Host -> (let Sock (open-socket Host 8000)
	       MessageSent (send-message (value *mailbox*) (value *initial-state*))
	       ThreadStore (add-to *thread-store* (make-thread (freeze (accept-connection Sock))))
	      Sock))

