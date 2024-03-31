Escreva uma função principal count_main: int -> int list que receba um número inteiro como entrada e conte de 1 em 1 até chegar neste número. Escreva uma segunda função count: int -> int list que receba o primeiro número que deva começar a contagem e faça qualquer regra necessária dentro desta função. A função count deve funcionar apenas dentro do escopo da função count_main.

Obs.: a contagem deve iniciar em 1.

Exemplo Geral:

input: count_main(n)

output: [1, 2, ..., ki, ..., n]

Exemplo 1:

input: count_main(5)

output: [1, 2, 3, 4, 5]

Exemplo 2:

input: count_main(1)

output: [1]
