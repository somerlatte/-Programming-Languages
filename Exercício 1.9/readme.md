Defina um tipo algébrico de dados dinheiro, que possa representar quantidades em centavos (tipo int), em reais (tipo real), ou um par Nome x reais. A partir desse tipo, defina uma função amount: dinheiro -> intque recebe um tipo dinheiro como entrada e retorne a quantidade em centavos correspondente à entrada.

Obs.: utilize a função round: real -> int para converter de real para inteiro

Exemplo 1

input: val d = Reais(2.0) : dinheiro

output: val it = 200 : int

Exemplo 2

input: val d = Centavos(2) : dinheiro

output: val it = 2 : int

Exemplo 3

input: val d = Pessoa Dinheiro(”Gene”, 2.5)) : dinheiro

output: val it = 250 : int
