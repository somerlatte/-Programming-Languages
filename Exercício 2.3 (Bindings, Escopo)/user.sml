fun count_main x =
    let
        fun count 0 = []
            | count x = count (x-1) @ [x]
    in
        count x
    end;

count_main(5);