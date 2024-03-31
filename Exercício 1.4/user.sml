(* implemente a função max *)

fun max ([]) = 0
  | max (x::[]) = x
  | max (x::y::z) = if x > y then max(x::z) else max(y::z);