Utilizando o ADT expr visto em aula: datatype expr = IConst of int | Plus of expr * expr | Minus of expr * expr; Estenda essa linguagem com os seguintes operadores:

Operação	Símbolo	⇒	Semântica

Multiplicação	(Multi)	⇒	Multiplica dois valores

Divisão	(Div)	⇒	Divisão inteira de dois valores. Divisão por 0 deve retornar 0.

Maior valor	(Max)	⇒	Retorna o maior de dois valores.

Menor Valor	(Min)	⇒	Retorna o menor de dois valores.

Igual	(Eq)	⇒	Retorna 1 se os valores são iguais, 0 caso contrário.

Maior que	(Gt)	⇒	Retorna 1 se o primeiro valor é estritamente maior que o segundo, e 0 caso contrário.

Estenda também a função eval : expr -> int para conseguir avaliar expressões que utilizem esses operadores.

Exemplo 1

input: val e1 = Max(IConst 3, Plus(IConst 2, IConst 3));

output: val it = 5 : int

Exemplo 1

input: val e2 = Div(Multi(IConst 5, IConst 4), Minus(IConst 4, IConst 4));

output: val it = 0 : int
