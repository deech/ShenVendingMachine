(defmacro connector-type-macro
  [connect-type Name TypeA X TypeB] ->
    (let Connector (gensym connector-)
     [datatype Name
        _________________
	 TypeA : Connector;

        TypeA : Connector;
	 __________
	 X : (eval TypeB);]));
