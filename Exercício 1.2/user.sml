(* implemente a função pow *)

fun pow (0, 0) = 0 | pow (0, e: int) = 0 | pow (n: int, 0) = 1 | pow (n: int, e: int) = (n * pow (n, e - 1));