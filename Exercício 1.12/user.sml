(* implemente a função multiPairs *)

fun multiPairs(lista1, lista2) = ListPair.map(fn (x, y) => x * y) (lista1, lista2);

multiPairs([2, 5, 10], [4, 10, 8]);