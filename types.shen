(datatype candy
  if (element? X (value *candy*))
  __________________
  X : candy;)
(datatype currency
  if (element? X (value *currency*))
  __________________
  X : currency;)
(datatype user
  if (== X user)
  _____________
  X : user;

  if (== X sudo)
  _______________
  X : user;)

(datatype ip-address
  if (is-ip-address X)
  ____________________
  X : ip-address;)

(datatype network
  ___________________________
  (value *my-server*) : socket;)
(datatype initial-state
  ____________________________
  (value *initial-state*) : state;

  X : (candyStore * coinStore);
  ============================
  X : state;)

(datatype command-line
  if (element? sudo X)
  __________________
  X : command-line;

  X : command-line;
  ___________________
  X : (list symbol);)
