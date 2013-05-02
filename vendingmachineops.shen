(define empty-state
  {--> state}
  -> (@p [] [(@p dollar 0) (@p quarter 0) (@p dime 0) (@p nickel 0)]))

(define show-coins
  { state --> string }
  (@p _ Coins) -> (show-alist Coins))

(define show-candy
  { state --> string }
  (@p Candy _) -> (show-alist
			(map
			 (/. CandyStock (@p (fst CandyStock)
					    (make-string "[~A ~A]"
						  (snd CandyStock)
					          (print-money (candy-cost (fst CandyStock))))))
			 Candy)))


(define show-help
  { --> string }
  ->
(make-string "~A~%"
"
list money                     - your balance
add quarter dollar ...         - add to your balance
buy hersheys                   - get a hersheys
cancel                         - return money
list candy                     - show available candy
sudo add hersheys snickers ... - restock candy
sudo add quarter dollar ..     - restock change
help                           - this message"))

(define process-request
  { state --> command-line --> state --> (string * state * state)}
  VM [user [add [currency Currencies]]] US -> (@p "Success."
						VM
						(@p (fst US) (add-coins (snd US) Currencies)))
  VM [sudo [add [currency Currencies]]] US -> (@p "Success."
						(@p (fst VM) (add-coins (snd VM) Currencies))
						US)
  VM [sudo [add [candy    Candies]]]    US -> (@p "Success."
						(@p (add-candies (fst VM) Candies) (snd VM))
						US)
  VM [user [add [candy    _]]]          US -> (@p "Only a super-user can add candy."
						VM
						US)
  VM [user [list candy]] US -> (@p (show-candy VM) VM US)
  VM [sudo [list candy]] US -> (@p (show-candy VM) VM US)
  VM [sudo [list money]] US -> (@p (show-coins VM) VM US)
  VM [user [list money]] US -> (@p (show-coins US) VM US)
  VM [sudo [buy  _]] US -> (@p "You're a super-user. Your money's no good here." VM US)
  VM [user [buy Candy]] US -> (buy-candy VM US Candy)
  VM [sudo [cancel]] US -> (@p "You're a super-user. No takesy-backsies!" VM US)
  VM [user [cancel]] US -> (@p (make-string "Returning:~%~A" (show-coins US))
			       VM
			       (empty-state))
  VM [sudo [help]]   US -> (@p (show-help) VM US)
  VM [user [help]]   US -> (@p (show-help) VM US)
  )

(define remove-candy
  {candy --> candyStore --> candyStore}
  Candy Store -> (with-key Store Candy (/. Stock (- Stock 1)))
  )

(define enough-candy?
  {candy --> state --> boolean}
  Candy VM -> (with-lookup Candy (fst VM) (/. Stock (> Stock 0)) false)
  )

(define enough-money?
  {candy --> state --> boolean}
  Candy UserState -> (>= (total-money (snd UserState)) (candy-cost Candy))
  )

(define total-money
  {coinStore --> number}
  Store -> (shen.sum (map (function total) Store)))

(define add-coins
  { coinStore --> (list currency) --> coinStore }
  CoinStore []             -> CoinStore
  CoinStore Coins -> (add-coins (add-coin CoinStore (head Coins)) (tail Coins)))

(define add-coin
  { coinStore --> currency --> coinStore}
  CoinStore Coin -> (with-key CoinStore Coin (+ 1)))

(define add-candies
  { candyStore --> (list candy) --> candyStore }
  CandyStore [] -> CandyStore
  CandyStore Candies -> (add-candies (add-candy CandyStore (head Candies)) (tail Candies)))

(define add-candy
  { candyStore --> candy --> candyStore}
  CandyStore Candy -> (with-key CandyStore Candy (+ 1)))

(define add-money
  {state --> coinStore --> state}
  State Cs
     -> (with-store
	      snd
	      (/. Store (merge-alists Store Cs +))
	      (/. NewS State (@p (fst State) NewS))
	      State))

(define with-store
  {(state --> (list (A * number))) -->
   ((list (A * number)) --> (list (A * number))) -->
   ((list (A * number)) --> state --> state) -->
   state -->
   state}
  Extract Transform PutBack State -> (let Store (Extract State)
				      NewStore (Transform Store)
				     (PutBack NewStore State)))

(define buy-candy-h
  { state --> state -->
    number -->
    candy -->
    (coinStore * coinStore) -->
    (string * state * state) }
  VM UserState 0 Candy _
    -> (@p (make-string "Enjoy your ~A" Candy)
	   (@p (remove-candy Candy (fst VM)) (snd VM))
	   (@p (fst UserState) (snd (empty-state))))
  VM UserState Owed Candy (@p NewTill Change)
    -> (@p (make-string "Enjoy your ~A" Candy)
	   (@p (remove-candy Candy (fst VM)) NewTill)
	   (@p (fst UserState) (pad-coinStore Change)))
  )

(define pad-coinStore
  {coinStore --> coinStore}
  CoinStore -> (merge-alists CoinStore (snd (empty-state)) +))

(define buy-candy
  {state --> state --> candy --> (string * state * state)}
  VM UserState Candy -> (if (enough-money? Candy UserState)
			    (if (enough-candy? Candy VM)
				(let MergedVM (add-money VM (snd UserState))
				     Owed     (- (total-money (snd UserState))
						 (candy-cost Candy))
				     Change   (change Owed (snd MergedVM))
				  (buy-candy-h MergedVM UserState Owed Candy Change))
				(@p "Not enough candy" VM UserState)
				)
			    (@p "Not enough money." VM UserState)
			    )
  )
