(synonyms state (candyStore * coinStore))
(datatype globals
  _____________________________
  (value *candy*) : (list candy);

  ____________________________________
  (value *currency*) : (list currency);

  ____________________________
  (value *initial-state*) : state;)

(datatype items

  if (element? X (value *currency*))
  ___________________________________
  X : currency;

  if (element? X (value *candy*))
  ___________________________________
  X : candy;)

(datatype stores

  X : (list (currency * number));
  ================================
  X : coinStore;

  X : (list (candy * number));
  ============================
  X : candyStore;)
