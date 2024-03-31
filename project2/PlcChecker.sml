(* PlcChecker *)

exception EmptySeq
exception UnknownType
exception NotEqTypes
exception WrongRetType
exception DiffBrTypes
exception IfCondNotBool
exception NoMatchResults
exception MatchResTypeDiff
exception MatchCondTypesDiff
exception CallTypeMisM
exception NotFunc
exception ListOutOfRange
exception OpNonList

fun teval (ConI _) _ = IntT |
    teval (ConB _) _ = BoolT |
    teval (ESeq seq) _ =
        let in
        case seq of
            SeqT t => SeqT t |
            _ => raise EmptySeq
        end |
    teval (Var v) (env:plcType env) = lookup env v |
    teval (Let(var, e1, e2)) (env:plcType env) =
        let val t1 = teval e1 env
        in teval e2 ((var, t1)::env)
        end |
    teval (Letrec(f, argT, arg, fType, e1, e2)) (env:plcType env) =	
        let
            val e1Type = teval e1 ((f, FunT(argT, fType))::(arg, argT)::env)
            val e2Type = teval e2 ((f, FunT(argT, fType))::env)
        in
            if e1Type = fType then e2Type
            else raise WrongRetType
        end |
    teval (Prim1(operation, e1)) (env:plcType env) =
        let in
            case operation of
                "!" => 
                    if (teval e1 env) = BoolT then BoolT
                    else raise UnknownType |
                "-" => 
                    if (teval e1 env) = IntT then IntT
                    else raise UnknownType |
                "hd" => 
                    if e1 <> ESeq(teval e1 env) then
                        let in
                            case (teval e1 env) of
                                (SeqT t) => t
                                | _ => raise UnknownType
                        end
                    else
                        raise EmptySeq |
                "tl" => 
                    let in
                        if e1 <> ESeq(teval e1 env) then
                            case (teval e1 env) of
                                (SeqT t) => (SeqT t)
                                | _ => raise UnknownType
                        else
                            raise EmptySeq
                    end |
                "ise" => 
                    let in
                        case (teval e1 env) of
                            (SeqT t) => BoolT
                            | _ => raise UnknownType
                    end |
                "print" => ListT[] |
                _  => raise UnknownType
        end |
    teval (Prim2(operation, e1, e2)) (env:plcType env) =
        let in
            case operation of
                "&&" => 
                    if (teval e1 env) = BoolT andalso (teval e2 env) = BoolT then BoolT
                    else raise UnknownType |
                "::" => 
                    let in
                        case (teval e1 env, teval e2 env) of
                            (IntT, ListT []) =>
                                SeqT IntT |
                            (IntT, SeqT t) =>
                                if t = IntT then SeqT t
                                else raise NotEqTypes |
                            (BoolT, ListT []) =>
                                SeqT BoolT |
                            (BoolT, SeqT t) =>
                                if t = BoolT then SeqT BoolT
                                else raise NotEqTypes |
                            (ListT t, ListT []) => SeqT(ListT t) |
                            (ListT t, SeqT s) =>
                                if s = (ListT t) then SeqT s
                                else raise NotEqTypes |
                            _ => raise UnknownType
                        end |
                "+" => 
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then IntT
                    else raise UnknownType |
                "-" =>
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then IntT
                    else raise UnknownType |
                "*" =>
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then IntT
                    else raise UnknownType |
                "/" => 
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then IntT
                    else raise UnknownType |
                "<" => 
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then BoolT
                    else raise UnknownType |
                "<=" => 
                    if (teval e1 env) = IntT andalso (teval e2 env) = IntT then BoolT
                    else raise UnknownType |
                "=" => 
                    let in
                        case (teval e1 env) of
                            IntT =>
                                if (teval e2 env) = IntT andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            BoolT =>
                                if (teval e2 env) = BoolT andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            SeqT t =>
                                let in
                                    case t of
                                        BoolT => BoolT |
                                        IntT => BoolT |
                                        ListT([]) => BoolT |
                                        _ => raise NotEqTypes
                                end |
                            ListT([]) =>
                                if (teval e2 env) = ListT([]) andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            ListT(types) =>
                                let
                                    val aux = map(
                                        fn(t) =>
                                            case t of
                                                BoolT => BoolT |
                                                IntT => IntT |
                                                ListT([]) => ListT([]) |
                                                _ => raise NotEqTypes
                                    ) types
                                in
                                    BoolT
                                end |
                            _ => raise NotEqTypes
                    end |
                "!=" => 
                    let in
                        case (teval e1 env) of
                            IntT =>
                                if (teval e2 env) = IntT andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            BoolT =>
                                if (teval e2 env) = BoolT andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            SeqT t =>
                                let in
                                    case t of
                                        BoolT => BoolT |
                                        IntT => BoolT |
                                        ListT([]) => BoolT |
                                        _ => raise NotEqTypes
                                end |
                            ListT([]) =>
                                if (teval e2 env) = ListT([]) andalso (teval e1 env) = (teval e2 env) then BoolT
                                else raise NotEqTypes |
                            ListT(types) =>
                                let
                                    val aux = map(
                                        fn(t) =>
                                            case t of
                                                BoolT => BoolT |
                                                IntT => IntT |
                                                ListT([]) => ListT([]) |
                                                _ => raise NotEqTypes
                                    ) types
                                in
                                    BoolT
                                end |
                            _ => raise NotEqTypes
                    end |
                ";" => (teval e2 env) |
                _ => raise UnknownType
        end |
    teval (If(e3, e2, e1)) (env:plcType env) =
        let in
            case (teval e3 env) of
                BoolT =>
                    if (teval e2 env) = (teval e1 env) then (teval e2 env)
                    else raise DiffBrTypes |
                _ => raise IfCondNotBool
        end |
    teval (Match(e1, matchList)) (env:plcType env) =
        if null matchList then raise NoMatchResults else
        let
            val firstCondition = teval e1 env
            val firstRes = (#2 (hd matchList))
            val firstResType = teval firstRes env
            fun findMatch (Match(e1, matchList)) (env:plcType env) =
                let in
                case matchList of
                    head::[] => let in
                        case head of
                            (SOME e2, e3) => 
                                if (teval e3 env) = firstResType then
                                    if firstCondition = (teval e2 env) then teval e3 env 
                                    else raise MatchCondTypesDiff
                                else raise MatchResTypeDiff |
                            (NONE, e3) => if (teval e3 env) = firstResType then firstResType else raise MatchResTypeDiff
                        end |
                    head::tail => let in
                        case head of
                            (SOME e2, e3) => 
                                if (teval e3 env) = firstResType then
                                    if firstCondition = (teval e2 env) then findMatch (Match(e1, tail)) env 
                                    else raise MatchCondTypesDiff
                                else raise MatchResTypeDiff |
                            _ => raise UnknownType
                        end
                end |
            findMatch _ _ = raise UnknownType
        in
            findMatch (Match(e1, matchList)) env
        end |
    teval (Call(e1, e)) (env:plcType env) =
        let in
            case (teval e1 env) of
                FunT(argT, resultType) =>
                    if (teval e env) = argT then resultType
                    else raise CallTypeMisM |
                _ => raise NotFunc
        end |
    teval ((List [])) (env:plcType env) = ListT [] |
    teval ((List l)) (env:plcType env) =
        let
            val ListMap = map(fn x => teval x env) l
        in
            ListT ListMap
        end |
    teval (Item(i, e)) (env:plcType env) =
        let
            fun getIndexElement(i, []) = raise ListOutOfRange |
                getIndexElement(i, (head::[])) =
                    if i = 1 then head
                    else raise ListOutOfRange |
                getIndexElement(i, (head::tail)) =
                    if i = 1 then head 
                    else getIndexElement(i - 1, tail)
        in
            case teval e env of
                ListT l => getIndexElement(i, l) |
                _ => raise OpNonList
        end |
    teval (Anon(s:plcType, x:string, e:expr)) (env:plcType env) =
        let
            val t = teval e ((x, s)::env)
        in
            FunT(s, t)
        end