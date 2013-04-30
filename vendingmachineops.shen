(define with-key
  { (list (A * B)) --> A --> (B --> B) --> (list (A * B)) }
  [(@p K V) | KVs] K F -> (append [(@p K (F V))] (with-key KVs K F))
  [KV | KVs] K F       -> (append [KV]           (with-key KVs K F))
  [] K F               -> [])

(define every
  {(list A) --> (A --> boolean) --> boolean}
  []       F -> false
  [A]      F -> (F A)
  [A | As] F -> (and (F A) (every As F))
 )

(define elements?
  {(list A) --> (list A) --> boolean}
  As Bs -> (every As (/. A (element? A Bs)))
  )

(define show-alist-h
  { (list (A * B)) --> string --> string }
  [(@p K V) | Is] Accum -> (show-alist-h Is (@s Accum (make-string "~A ~A~%" K V)))
  [] ""    -> "No contents"
  [] Accum -> Accum)

(define show-alist
  { (list (A * B)) --> string }
  Alist -> (show-alist-h Alist ""))

(define show-coins
  { state --> string }
  (@p _ Coins) -> (show-alist Coins))
(define show-candy
  { state --> string }
  (@p Candy _) -> (show-alist Candy))

(define process-request
  { state --> command-line --> state --> (string * state * state)}
  VM [sudo add [currency Currencies]] US -> (@p "" (@p [] []) (@p [] []))
  VM [sudo add [candy    Candies]]    US -> (@p "" (@p [] []) (@p [] []))
  VM [user add [currency Currencies]] US -> (@p "" VM (@p (fst US) (add-coins (snd US) [])))
  VM [user add [candy    _]]          US -> (@p "Only a super-user can add candy to the machine." VM US)
  VM [user list candy] US -> (@p (show-candy US) VM US)
  VM [sudo list candy] US -> (@p (show-candy VM) VM US)
  VM [user list money] US -> (@p (show-coins US) VM US)
  VM [sudo buy  _] US -> (@p "You're a super-user. You can just take candy." VM US)
  VM [sudo cancel] US -> (@p "You're a super-user. No takesy-backsies!" VM US)
  VM [user cancel] US -> (@p "" (@p [] []) (@p [] []))
  )

(define add-coins
  { coinStore --> (list currency) --> coinStore }
  CoinStore []             -> CoinStore
  CoinStore Coins -> (add-coins (add-coin CoinStore (head Coins)) (tail Coins)))

(define add-coin
  { coinStore --> currency --> coinStore}
  CoinStore Coin -> (with-key CoinStore Coin (+ 1)))
