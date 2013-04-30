(synonyms state (candyStore * coinStore)
          candyStore (list (candy * number))
	  coinStore (list (currency * number)))

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
  X : candy;

  X : (list A);
  _____________________________________________
  [currency X] : (list currency);

  ____________________________________________________________
  (elements? X (value *candy*)) : verified >> X : (list candy);

  __________________________________________________________________
  (elements? X (value *currency*)) : verified >> X : (list currency);
  )
