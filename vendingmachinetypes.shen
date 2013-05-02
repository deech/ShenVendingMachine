(synonyms state      (candyStore * coinStore)
          candyStore (list (candy * number))
	  coinStore  (list (currency * number)))

(datatype globals
  _____________________________
  (value *candy*) : (list candy);

  ____________________________________
  (value *currency*) : (list currency);

  ____________________________
  (value *initial-state*) : state;
  )

(datatype items

  if (element? X (value *currency*))
  ___________________________________
  X : currency;

  if (element? X (value *candy*))
  _______________________________
  X : candy;

  ____________________
  [candy X] : command;


  [candy X] : command;
  ___________________
  X : (list candy);

  _________________
  [buy X] : command;

  [buy X] : command;
  _________________
  X : candy;
 )

(connect-type currency-type [currency X] X [list currency])
