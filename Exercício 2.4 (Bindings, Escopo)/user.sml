(* implemente a função pow *)

fun pow x =
    let
        fun calculePow y = y * y
    in
        calculePow x
 end;

 pow(3);