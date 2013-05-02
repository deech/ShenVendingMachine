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

(datatype socket
  if (IS-STREAMING-SOCKET X)
  ________________
  X : socket;)

(datatype network
  ___________________________
  (value *my-server*) : socket;)

(datatype command-line
  __________________
  [sudo X] : command-line;

  ___________________
  [user X] : command-line;)
