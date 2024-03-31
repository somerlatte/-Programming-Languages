(* implemente a função amount *)
(* Use a função round: real -> int para converter real para inteiro *)

datatype dinheiro = Centavos of int 
    | Reais of real 
    | Pessoa_Dinheiro of string * real;

fun amount (Reais x) = round(x*100.0)
 |  amount (Centavos x) = x
 |  amount (Pessoa_Dinheiro (s,r)) = round(r*100.0);