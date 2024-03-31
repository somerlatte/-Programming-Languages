(* Plc interpreter main file *)


CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm");

use "Environ.sml";
use "Absyn.sml";
use "PlcParserAux.sml";
use "PlcParser.yacc.sig";
use "PlcParser.yacc.sml";
use "PlcLexer.lex.sml";

use "Parse.sml";
use "PlcChecker.sml";
use "PlcInterp.sml";

Control.Print.printLength := 1000;
Control.Print.printDepth  := 1000;
Control.Print.stringDepth := 1000;

open PlcFrontEnd;

fun run e = 
    let
        val tevalResult = type2string(teval e [])
        val evalResult = val2string(eval e [])
    in
        evalResult ^ " : " ^ tevalResult
    end
    handle 
        EmptySeq => "Erro: A sequência de entrada não contém nenhum elemento"
		| UnknownType => "Erro: Tipo desconhecido"
		| NotEqTypes => "Erro: Os tipos usados na comparação são diferentes"
		| WrongRetType => "Erro: O tipo de retorno da função não condiz com o corpo da mesma"
		| DiffBrTypes => "Erro: Os tipos da expressões dos possíveis caminhos de um If divergem"
		| IfCondNotBool => "Erro: A condição do if não é booleana"
		| NoMatchResults => "Erro: Não há resultados para a expressão match"
		| MatchResTypeDiff => "Erro: O tipo de algum dos casos em match difere dos demais"
		| MatchCondTypesDiff => "Erro: O tipo das opções de match difere do tipo da expressão passada para Match"
		| CallTypeMisM => "Erro: Você está passando pra uma chamada de função um tipo diferente do qual ela suporta"
        | NotFunc => "Erro: Voce esta tentando chamar algo que nao e uma funcao!"
		| ListOutOfRange => "Erro: Tentativa de acessar um elemento fora dos limites da lista"
		| OpNonList => "Erro: Tentativa de acessar um elemento em uma expressão que não é uma lista"
		| SymbolNotFound => "Erro: Variavel nao definida"
		| Impossible => "Erro: Nao foi possivel avaliar a expressao"
		| HDEmptySeq => "Erro: Nao e possivel aplicar a funcao head a uma lista vazia"
		| TLEmptySeq => "Erro: Nao e possivel aplicar a funcao tail a uma lista vazia"
		| ValueNotFoundInMatch => "Erro: Valor da expressao nao encontrado no match."
		| NotAFunc => "Erro: Tentativa de chamar uma expressao que nao e uma funcao"
;