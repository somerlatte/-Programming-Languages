(* implemente a função sumAll *)

datatype btree = Leaf | Node of (btree * int * btree);

fun sumAll(Node (left, middle, right)) = sumAll(left) + middle + sumAll(right)
  | sumAll Leaf = 0;