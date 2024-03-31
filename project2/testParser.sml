(* Infrastructure to run the Plc Front-End *)

CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm");

use "Environ.sml";
use "Absyn.sml";
use "PlcParserAux.sml";
use "PlcParser.yacc.sig";
use "PlcParser.yacc.sml";
use "PlcLexer.lex.sml";

use "Parse.sml";

Control.Print.printLength := 1000;
Control.Print.printDepth  := 1000;
Control.Print.stringDepth := 1000;

open PlcFrontEnd;

fromString "34";
fromString "false";
fromString "()";
fromString "(6,true)[0]";
fromString "([Bool] [])";
fromString "print x; true";
fromString "3::9::t";
fromString "fn (Int x) => -x end";
fromString "var x = 5; x + 2";
fromString "fun g(Int x) = x; g(1)";
fromString "match x with | 0 -> 1| _ -> -1 end";
fromFile ("example.plc");

use "testParserCases.sml"

(* Try to add a systematic way of using the test cases in
   testParserCases to stress test your parser *)
