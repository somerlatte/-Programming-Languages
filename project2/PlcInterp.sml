(* PlcInterp *)

exception Impossible
exception HDEmptySeq
exception TLEmptySeq
exception ValueNotFoundInMatch
exception NotAFunc

fun eval (e:expr) (env:plcVal env) : plcVal =
	case e of
			ConI i => IntV i
      	| 	ConB b => BoolV b
		| 	Var x => lookup env x
      	| 	List l => ListV (evalList l env)
      	| 	ESeq (l: plcType) => SeqV []
		|	Prim1(opr, e1) =>
				let
					val v1 = eval e1 env
				in
					case (opr, v1) of
							("-", IntV i) => IntV (~i) 			
						| 	("!", BoolV b) => BoolV (not b) 		
						|	("ise", SeqV []) => BoolV true 		
						|	("ise", SeqV _) => BoolV false 		
						|	("hd", SeqV []) => raise HDEmptySeq 
						| 	("hd", SeqV l) => (hd l) 				
						|	("tl", SeqV []) => raise TLEmptySeq 
						| 	("tl", SeqV l) => SeqV (tl l)				
						|	("print", _) =>
								let
									val s = val2string v1
								in
									print(s^"\n"); ListV []
								end 							
						| 	_   => raise Impossible
				end
		| 	Prim2(opr, e1, e2) =>
				let
					val v1 = eval e1 env
					val v2 = eval e2 env
				in
					case (opr, v1, v2) of
							("*",  IntV i1, IntV i2) => IntV (i1 * i2)
						| 	("/",  IntV i1, IntV i2) => IntV (i1 div i2)
						| 	("+",  IntV i1, IntV i2) => IntV (i1 + i2)
						| 	("-",  IntV i1, IntV i2) => IntV (i1 - i2)
						| 	("<",  IntV i1, IntV i2) => BoolV (i1 < i2)
						| 	("<=", IntV i1, IntV i2) => BoolV (i1 <= i2)
						| 	("=",  IntV i1, IntV i2) => BoolV (i1 = i2)
						| 	("!=", IntV i1, IntV i2) => BoolV (not(i1 = i2))
						| 	("=",  BoolV b1, BoolV b2) => BoolV (b1 = b2)
						| 	("!=", BoolV b1, BoolV b2) => BoolV (not(b1 = b2))
						| 	("&&", BoolV b1, BoolV b2) => BoolV (b1 andalso b2)
						| 	("::", _, SeqV l) => SeqV (v1::l)
						| 	(";" , _ , _) => v2
						| 	_ => raise Impossible
						end
		| 	Let(x, e1, e2) =>
				let
					val v = eval e1 env
					val env2 = (x, v) :: env
				in
					eval e2 env2
				end
		|	If(cond, e1, e2) => 
				if (eval cond env = BoolV true) then 
					eval e1 env 
				else 
					eval e2 env
		| 	Letrec(funName, _, argName, _, e1, e2) =>
				eval e2 ((funName, Clos(funName, argName, e1, env))::env)
		|	Anon(_, argName, e1) => Clos("", argName, e1, env)
		|	Call(e1, arg) =>
				let
					val closure = eval e1 env
					val argVal = eval arg env
				in
					case closure of 
						Clos(funName, argName, e2, envC) =>
							eval e2 ((argName, argVal)::(funName, closure)::envC)
						| _ => raise NotAFunc
				end
		|	Match(e1, eList) => 
				if eList = [] then
					raise Impossible
				else
					let
						val eValue = eval e1 env
					in
						findMatch eValue eList env
					end
		|	Item(i, e) => 
				let
					val eVal = eval e env
				in
					case eVal of 
						ListV l => (getItem l i)
						| _ => raise Impossible
				end
		(* | _ => raise Impossible *)

and evalList [] env = []
  | evalList (h::t) env = (eval h env)::(evalList t env)

and findMatch eValue [] env = raise ValueNotFoundInMatch
  | findMatch eValue (((SOME match), exp)::t) env = 
        let
          	val matchValue = eval match env
        in
          	if eValue = matchValue then
            	eval exp env
          	else
				findMatch eValue t env
        end
  | findMatch eValue ((NONE, exp)::t) env = 
        eval exp env

and getItem [] _ = raise Impossible
  | getItem (h::t) 1 = h
  | getItem (h::t) ind = getItem t (ind-1);
