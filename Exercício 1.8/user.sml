(* implemente a função allTrue *)

fun allTrue([]) = false
	| allTrue([x]) = x = true
	| allTrue(x::y) =
		x = true andalso allTrue(y);

allTrue([true, true, false, true]);