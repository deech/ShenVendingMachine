(declare startup [--> unit])
(define startup
 -> (let Sock (open-socket "localhost" 8000)
      (do (send-message (value *mailbox*) (value *initial-state*))
          (add-to *thread-store* (make-thread (freeze (accept-connection Sock)))))))

