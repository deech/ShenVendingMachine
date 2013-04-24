\*
  everything can be prefixed with sudo
  list candy
  list money -- user's money or vending machine money
  fill candy snickers -- hashtable
  add [quarter, dime, nickel,dollar]
  buy
  cancel
*\
(package parser [<instructions>]
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
