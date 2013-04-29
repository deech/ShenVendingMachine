(package initial [*candy* *currency* quarter dime nickel dollar snickers hersheys twix *mailbox* *connectionStore* *thread-store* add-to reset]
  (set *candy* [snickers hersheys twix])
  (set *currency* [quarter dime nickel dollar])
  (set *connectionStore* [])
  (set *thread-store* [])
  (set *mailbox* nil)
  (define add-to
    Global Value -> (set Global (append [Value] (value Global))))
  (define reset
    -> (do (set *connectionStore* [])
	   (set *thread-store* [])
	   (set *mailbox* (((protect READ-FROM-STRING) "SB-CONCURRENCY::MAKE-MAILBOX")))))  
)
