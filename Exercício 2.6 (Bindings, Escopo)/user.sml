(* implemente a função split *)

fun split([]) = ([], [])
    | split([x]) = ([x], [])
    | split(first::middle::last) = 
    let
        val (left, right) = split(last)
    in
        ((first::left), (middle::right))
    end;

split([1,2,3,8,4,5]);
split([1,4,3]);