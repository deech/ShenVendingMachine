(datatype user
  if (== X user)
  _____________
  X : user;

  if (== X sudo)
  _______________
  X : user;)

(datatype ip-address

  if (is-ip-address X) 
  __________________________________
  X : ip-address;
 )

(datatype socket

  ______________________
  (is-socket X) : verified >> X : socket;)

(datatype network
  ___________________________
  (value *my-server*) : socket;)

(datatype command-line
  __________________
  [sudo X] : command-line;

  ___________________
  [user X] : command-line;)


(datatype globals
  ____________________________
  (value *initial-state*) : state;

  _____________________________
  (value *mailbox*) : mailbox;
  )

(datatype items

  if (element? X (value *currency*))
  ___________________________________
  X : currency;

  if (element? X (value *candy*))
  _______________________________
  X : candy;
 )

(synonyms state      (candyStore * coinStore)
          candyStore (list (candy * number))
	  coinStore  (list (currency * number)))
