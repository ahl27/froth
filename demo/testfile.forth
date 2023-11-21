: R%  10 */  5 +  10 %/% ;
: MULTIPLICATIONS  CR 11 1 DO  DUP I * .  LOOP  DROP ;
: COMPOUND  ( amount interest -- ) CR SWAP 21 1 DO  ." YEAR " I . 3 SPACES \
  2DUP R% +  DUP ." BALANCE " . CR  LOOP  2DROP ;
: TABLE     CR 11 1 DO  11 1 DO  I J *  5 U.R  LOOP CR LOOP ;

7 multiplications
1000 6 compound
table
