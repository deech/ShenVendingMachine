(synonyms candyStore (list (candy * number)))
(declare process-request [state --> [command-line --> [state --> [string * state * state]]]])
(define process-request
  VM [sudo add [currency | Currencies]] US -> (@p "" (@p [] []) (@p [] []))
  VM [sudo add [candy    | Candies]] US -> (@p "" (@p [] []) (@p [] []))
  VM [user add [currency | Currencies]] US -> (@p "" (@p [] []) (@p [] []))
  VM [user add  _ ] US -> (@p "Only a super-user can add candy to the machine." VM US)
  VM [_    list candy] US -> (@p (make-string "~A" (fst VM)) VM US)
  VM [user list money] US -> (@p (make-string "~A" (snd US)) VM US)
  VM [sudo list money] US -> (@p (make-string "~A" (snd VM)) VM US)
  VM [sudo buy  _] US -> (@p "You're a super-user. You can just take candy." VM US)  \* super-user can't buy\ *\
  VM [sudo cancel] US -> (@p "You're a super-user. No takesy-backsies!" VM US)  \* super-user can't cancel\ *\
  VM [user cancel] US -> (@p "" (@p [] []) (@p [] [])))
:
