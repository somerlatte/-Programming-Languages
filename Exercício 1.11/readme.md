Considerando a definição de Binary Search Tree vista na aula sobre tipos de dados algébricos: datatype btree = Leaf | Node of (btree * int * btree); Escreva uma função sumAll: btree -> int que percorra a árvore retorne a soma de todos os valors nos nós internos desta.

Exemplo 1

input: val t = Node (Node (Leaf, 1, Leaf), 6, Node (Leaf, 12, Leaf))

output: val it = 19 : int
