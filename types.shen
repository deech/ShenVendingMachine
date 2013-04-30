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

(datatype command-line
  if (or (element? sudo X) (element? user X))
  __________________
  X : command-line;)
