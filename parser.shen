\*
  everything can be prefixed with sudo
  list candy
  list money -- user's money or vending machine money
  fill candy snickers -- hashtable
  add [quarter, dime, nickel,dollar]
  buy
  cancel
*\
(package parser (append (external initial) [<instructions> <ip-address>])
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
  (defcc <vending-machine-state>
    money;
    candy;)
  (defcc <instruction>
    list <vending-machine-state>;
    add <inputs>;
    buy;
    cancel;
    quit;)
  \* entry point *\
  (defcc <instructions> <sudo> <instruction>;)
)
