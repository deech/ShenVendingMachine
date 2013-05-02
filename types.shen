(datatype user
  if (== X user)
  _____________
  X : user;

  if (== X sudo)
  _______________
  X : user;)

(datatype ip-address
	  
  (is-ip-address X):verified;
  ____________________
  X : ip-address;)

(datatype socket
  (is-socket X):verified;
  _______________
  X : socket;)

(datatype network
  ___________________________
  (value *my-server*) : socket;)

(datatype command-line
  __________________
  [sudo X] : command-line;

  ___________________
  [user X] : command-line;)
