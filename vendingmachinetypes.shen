(synonyms state      (candyStore * coinStore)
          candyStore (list (candy * number))
	  coinStore  (list (currency * number)))

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

  _________________________
  [candy X] : command;


  [candy X] : command;
  _________________________
  X : (list candy);

  _________________________
  [buy X] : command;

  [buy X] : command;
  _____________________
  X : candy;
  
  _______________________
  [currency X] : command;


  [currency X] : command;
  _______________________
  X : (list currency);)
