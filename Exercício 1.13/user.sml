(* implemente a função compose *)

fun sum(f, g) = f + g;
fun square(x) = x * x;
fun compose(a,b,c,d) = a(b(c,d));

compose(square, sum, 4, 5);