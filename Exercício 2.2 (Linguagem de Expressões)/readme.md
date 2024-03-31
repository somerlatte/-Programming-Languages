Escreva uma linguagem que calcule a área de objetos quadrados, retangulares, e circulares. Você deve definir o ADT area. Os nomes dos construtores de area devem seguir o seguinte padrão:
datatype area = RConst of real | AQuadrado of area | ARetangulo of area * area | ACirculo of area

Defina também a função abaixo para realizar a interpretação dessas expressões.

eval : area -> real

IMPORTANTE: as medidas desses objetos deveram ser do tipo real.

Considere π = 3.14

Exemplo 1

input: val e = ACirculo(RConst 2.0);

output: val it = 12.56: real;
