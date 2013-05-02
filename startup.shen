(declare startup [--> unit])
(define startup
 Host -> (let Sock (open-socket Host 8000)
          (do (send-message (value *mailbox*) (value *initial-state*))
            (add-to *thread-store* (make-thread (freeze (accept-connection Sock)))))))

