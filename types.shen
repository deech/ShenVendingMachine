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
