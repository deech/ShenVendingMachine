(define faceValue
  {currency --> number}
  quarter -> 25
  dime    -> 10
  nickel  -> 5
  dollar  -> 100)

(define candy-cost
  {candy --> number}
  snickers -> 100
  twix -> 125
  hersheys -> 75
  payday -> 95)

(define total
  {(currency * number) --> number}
  (@p Coin CoinAmount) -> (* (faceValue Coin) CoinAmount))

(define change
  {number --> coinStore --> (coinStore * coinStore)}
  Amount Till -> (trap-error (change-h Amount Till [] []) (/. E (@p Till []))))

(define merge-tills
  { coinStore --> coinStore --> coinStore }
  Till1 Till2 -> (append Till1 Till2))

(define change-h
  {number -->
   coinStore -->
   coinStore -->
   coinStore -->
   (coinStore * coinStore)}
  0 OldTill NewTill Change -> (@p (append NewTill OldTill) Change)
  Amount [] _ _ -> (error "Not enough in the till")
  Amount [(@p Coin CoinAmount) | Coins] NewTill Change ->
            (change-h Amount Coins (merge-tills NewTill [(@p Coin CoinAmount)]) Change)
  	    where (> (faceValue Coin) Amount)
  Amount [(@p Coin CoinAmount) | Coins ] NewTill Change ->
            (let CoinsAndLeftover (/mod Amount (faceValue Coin))
  	         Needed           (fst CoinsAndLeftover)
  	         Leftover         (snd CoinsAndLeftover)
  	         EnoughCoins      (< Needed CoinAmount)
  	      (if EnoughCoins
  		  (change-h (- Amount (total (@p Coin Needed)))
  			    Coins
  			    (merge-tills NewTill [(@p Coin (- CoinAmount Needed))])
  			    (merge-tills Change [(@p Coin Needed)]))
  		  (change-h (- Amount (total (@p Coin CoinAmount)))
  			    Coins
  			    (merge-tills NewTill [(@p Coin 0)])
  			    (merge-tills Change [(@p Coin CoinAmount)]))))
  )
