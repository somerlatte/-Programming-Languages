(* implemente a função simplify *)

datatype UnOp = Not;
datatype BinOp = Add | Sub | Mul | Or | Eq | Gt;

datatype Sexpr = IConst of int | Op1 of UnOp * Sexpr | Op2 of BinOp * Sexpr * Sexpr;

fun simplify (Op2(Add, a, IConst 0)) = simplify a
  | simplify (Op2(Add, IConst 0, a)) = simplify a
  | simplify (Op2(Sub, a, IConst 0)) = simplify a
  | simplify (Op2(Mul, a, IConst 1)) = simplify a
  | simplify (Op2(Mul, IConst 1, a)) = simplify a
  | simplify (Op2(Mul, _, IConst 0)) = IConst 0
  | simplify (Op2(Mul, IConst 0, _)) = IConst 0
  | simplify (Op2(Sub, a, b)) = if ((simplify a) = (simplify b)) then (IConst 0) else (if ((simplify b) = IConst 0) then (simplify a) else (Op2(Sub, simplify a, simplify b)))
  | simplify (Op1(Not, Op1(Not, a))) = simplify a
  | simplify (Op2(Or, a, b)) = if ((simplify a) = (simplify b)) then (simplify a) else (Op2(Or, simplify a, simplify b))
  | simplify w = 
    case w of
             (Op1(Op, a)) =>
                             let val b = (simplify a) in
                               if (b = a) 
								 then w 
							   else 
								 simplify (Op1(Op, b)) 
							 end
           | (Op2(Op, a, b)) => 
                                 let val z1 = (simplify a) 
                                     val z2 = (simplify b) in
								        if (z1 = a) andalso (z2 = b) 
										   then w
										else 
										  simplify (Op2(Op, z1, z2)) 
										end
           | _ => w;