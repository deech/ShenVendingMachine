(defmacro cl-call [cl F] -> [[protect READ-FROM-STRING] [[protect STRING-UPCASE] F]])
(package native-calls [my-reverse load-lisp readtable]
(define load-lisp
  File -> (trap-error
	     (let LispReadTable (readtable upcase)
	          Load ((protect LOAD) File)
		  ShenReadTable (readtable preserve)
		  loaded)
	     (/. E (do (readtable preserve) (error (error-to-string E))))))

(define readtable
    Case -> (let String
	         (make-string "(SETF (READTABLE-CASE *READTABLE*) ~A)"
		               (cases (= Case upcase) ":UPCASE"
				      (= Case downcase) ":DOWNCASE"
				      (= Case preserve) ":PRESERVE"
				      (= Case invert) ":INVERT"
				      true (error "case ~A not recognised~%" Case)))
	        ((protect EVAL) ((protect READ-FROM-STRING) String))))
(declare my-reverse [[list A] --> [list A]])
(define my-reverse X -> ((protect REVERSE) X))
)
