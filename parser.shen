\* IP Address parser *\
(defcc <ip-address>
  <octet-1> shen.<stop>
  <octet-2> shen.<stop>
  <octet-3> shen.<stop>
  <octet-4>             := [<octet-1> <octet-2> <octet-3> <octet-4>];
  <e>;)

(defcc <octet-1> <octet> := <octet>;)
(defcc <octet-2> <octet> := <octet>;)
(defcc <octet-3> <octet> := <octet>;)
(defcc <octet-4> <octet> := <octet>;)

(defcc <octet>
  shen.<digits> := (let Number (shen.pre (reverse shen.<digits>) 0)
  		     (if (<= Number 255 ) Number (fail))))

\* command parser *\
(defcc <line-read>
  shen.<whitespaces> shen.<atom> <line-read> := [shen.<atom> | <line-read>];
  shen.<atom> <line-read> shen.<whitespaces>:= [shen.<atom> | <line-read>];
  shen.<atom> <line-read> := [shen.<atom> | <line-read>];
  <e> := [];)
(defcc <sudo>
  sudo;
  := [user];)
(defcc <candy>    C := [C] where (element? C (value *candy*));)
(defcc <currency> C := [C] where (element? C (value *currency*));)
(defcc <candies>
  <candy> <candies>;
  <candy>;)
(defcc <currencies>
  <currency> <currencies>;
  <currency>;)
(defcc <inputs>
  <candies>    := [candy   | [<candies>]   ];
  <currencies> := [currency| [<currencies>]];)
(defcc <instruction>
  list <vending-machine-state>;
  add <inputs>;
  buy <candy>;
  cancel;)
(defcc <vending-machine-state>
  candy;
  money;)
(defcc <instructions>
  <sudo> <instruction>;)

(declare parse-command-line [string --> command-line])
(define parse-command-line
   Line -> (let Separated (map (function string->n) (explode Line))
	        Symbols   (compile (function <line-read>) Separated)
	     (compile (function <instructions>) Symbols)))

(define is-command-line
  [sudo | Xs] -> (do (output "~A" "true") true)
  [user | Xs] -> (do (output "~A" "true") true)
  _           -> (do (output "~A" "false") false))
