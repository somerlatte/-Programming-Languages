(* implemente a função greet *)

fun greet ("") = "Hello nobody"
  | greet (s:string) = "Hello " ^ s;

greet ("Janis");