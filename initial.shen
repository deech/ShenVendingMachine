(package initial [*candy* *currency* quarter dime nickel dollar snickers hersheys twix *mailbox* *connectionStore* *thread-store* add-to reset *initial-state*]
  (set *candy* [snickers hersheys twix])
  (set *currency* [quarter dime nickel dollar])
  (set *connectionStore* [])
  (set *thread-store* [])
  (set *mailbox* (((protect READ-FROM-STRING) "SB-CONCURRENCY::MAKE-MAILBOX")))
  (set *initial-state* (@p [(@p snickers 2) (@p twix 20) (@p hersheys 10)]
			   [(@p dollar 3) (@p quarter 10) (@p dime 13) (@p nickel 24)]))
  (define add-to
    Global Value -> (set Global (append [Value] (value Global))))
  (define reset
    -> (do (set *connectionStore* [])
	   (set *thread-store* [])
	   (set *mailbox* (((protect READ-FROM-STRING) "SB-CONCURRENCY::MAKE-MAILBOX")))))
)
