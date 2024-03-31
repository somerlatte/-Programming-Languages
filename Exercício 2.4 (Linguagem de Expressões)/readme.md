Compiladores frequentemente aplicam otimizações com intuito de deixar o código gerado mais eficiente. Um exemplo comum é a simplificação de expressões, utilizando propriedades aritméticas e/ou Booleanas.

Dados os ADT’s abaixo:

datatype UnOp = Not;

datatype BinOp = Add | Sub | Mul | Gt | Eq | Or;

datatype Sexpr = IConst of int | Op1 of UnOp * Sexpr | Op2 of BinOp * Sexpr * Sexpr;

Escreva uma função simplify : Sexpr -> Sexpr que seja capaz de simplificar expressões Sexpr de acordo com as regras de simplificação listadas abaixo ( ∨ simboliza disjunção lógica e ¬ simboliza negação lógica):
0	+	e	→	e

e	+	0	→	e

e	−	0	→	e

1	∗	e	→	e

e	∗	1	→	e

0	∗	e	→	0

e	∗	0	→	0

e	−	e	→	0

e	∨	e	→	e

¬(¬e)	→	e

A sua função deve ser capaz de simplificar, por exemplo, as expressões x + 0, 1 ∗ x, e (1 + 0) ∗ (x + 0) para somente x. O retorno deve ser uma expressão que não possa ser mais simplificada.

DICAS:

Não se esqueça dos casos em que não é possível mais simplificar.

Passos recursivos podem ser necessários para produzir expressões que não são simplificáveis.

“You ain’t never had a friend like pattern matching.”

Exemplo 1

input: Op2(Mul, Op2(Add, IConst 1, IConst 0), Op2(Add, IConst 9, IConst 0));

output: val it = IConst 9: Sexpr;

Exemplo 2

input: Op2 (Mul, Op2 (Add, IConst 1, IConst 0), Op2 (Add, Op2 (Or, IConst 10, IConst 12), IConst 0)): Sexpr;

output: val it = Op2 (Or, IConst 10, IConst 12): Sexpr;
