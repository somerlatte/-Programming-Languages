Utilizando combinadores, escreva um programa em ML com uma função compose : ('a -> 'b) * ('c * 'd -> 'a) * 'c * 'd -> 'b que retorne o quadrado da soma de dois números inteiros. Além de definir a função compose, você também deve, necessariamente, definir as funções square : int -> int e  sum : int * int -> int, com esses nomes e assinaturas de tipo.

Exemplo 1

input: (square, sum, 4, 5)

output: val it = 81 : int
