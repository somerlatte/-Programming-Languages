Escreva uma função split: string -> string list que receba uma frase f e retorne uma lista em que cada elemento é uma palavra de f. Considere que cada palavra na frase pode estar separada por espaço, ou pelos caracteres ”,” (virgula), ”.” (ponto), ou ”-” (traço simple).

A biblioteca de SML é muito rica, e apresenta diversas interfaces que assistem o programador dessa linguagem. Pesquisem sobre as interfaces de SML STRING e CHAR. Elas possuem métodos que vão auxiliar nessa questão. Note que para usar funções dessas bibliotecas é necessário adicionar o nome da biblioteca antes. Por exemplo, para chamar a função 'f' da biblioteca de String, é necessário usar a sintaxe 'String.f'.

Exemplo 1

input: ”Bom dia,pra-você”

output: val it = [”Bom”, ”dia”, ”pra”, ”você”] : string list
