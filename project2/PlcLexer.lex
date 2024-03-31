(* Plc Lexer *)

(* User declarations *)

open Tokens
type pos = int
type slvalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (slvalue, pos)token

(* A function to print a message error on the screen. *)
val error = fn x => TextIO.output(TextIO.stdOut, x ^ "\n")
val lineNumber = ref 0

(* Get the current line being read. *)
fun getLineAsString() =
    let
        val lineNum = !lineNumber
    in
        Int.toString lineNum
    end

(* Define what to do when the end of the file is reached. *)
fun eof () = Tokens.EOF(0,0)

fun keywords (s, lpos, rpos) = 
	case s of
		"var" => VAR(lpos, rpos)
        | "fun" => FUN(lpos, rpos)
        | "fn" => FN(lpos, rpos)
        | "if" => IF(lpos, rpos)
        | "else" => ELSE(lpos, rpos)
        | "then" => THEN(lpos, rpos)
        | "Nil" => NIL(lpos, rpos)
        | "hd" => HD(lpos, rpos)
        | "tl" => TL(lpos, rpos)
        | "print" => PRINT(lpos, rpos)
        | "ise" => ISE(lpos, rpos)
        | "Bool" => BOOL(lpos, rpos)
        | "Int" => INT(lpos, rpos)
        | "match" => MATCH(lpos, rpos)
        | "with" => WITH(lpos, rpos)
        | "rec" => REC(lpos, rpos)
        | "end" => END(lpos, rpos)
        | "true" => TRUE(lpos, rpos)
        | "false" => FALSE(lpos, rpos)
        | "_" => UNDER(lpos, rpos)
        | _ => NAME(s, lpos, rpos)


fun str_to_int s =
	case Int.fromString s of
		SOME i => i
		| NONE => raise Fail("Could't convert the string " ^ s ^ " to integer")

(* Initialize the lexer. *)
fun init() = ()
%%

%header (functor PlcLexerFun(structure Tokens: PlcParser_TOKENS));
digit=[0-9];
whitespace=[\ \t];
identifier=[a-zA-Z_][a-zA-Z_0-9]*;
%s COMMENT;
startcomment=\(\*;
endcomment=\*\);

%%

\n => (lineNumber := !lineNumber + 1; lex());
<INITIAL>{whitespace}+ => (lex());
<INITIAL>{digit}+ => (NAT(str_to_int(yytext),yypos, yypos));
<INITIAL>{identifier} => (keywords(yytext, yypos, yypos));
<INITIAL>"-" => (MINUS(yypos, yypos));
<INITIAL>"+" => (PLUS(yypos, yypos));
<INITIAL>"*" => (MULT(yypos, yypos));
<INITIAL>"/" => (DIV(yypos, yypos));
<INITIAL>"(" => (LPAR(yypos, yypos));
<INITIAL>")" => (RPAR(yypos, yypos));
<INITIAL>"{" => (LBRACE(yypos, yypos));
<INITIAL>"}" => (RBRACE(yypos, yypos));
<INITIAL>"[" => (LBRACK(yypos, yypos));
<INITIAL>"]" => (RBRACK(yypos, yypos));
<INITIAL>"=" => (EQ(yypos, yypos));
<INITIAL>"!=" => (DIFF(yypos, yypos));
<INITIAL>"<" => (LESS(yypos, yypos));
<INITIAL>"<=" => (LESSEQ(yypos, yypos));
<INITIAL>"->" => (ARROW(yypos, yypos));
<INITIAL>"=>" => (LAMBDA(yypos, yypos));
<INITIAL>":" => (COLON(yypos, yypos));
<INITIAL>"::" => (DCOLON(yypos, yypos));
<INITIAL>"&&" => (AND(yypos, yypos));
<INITIAL>"|" => (PIPE(yypos, yypos));
<INITIAL>";" => (SEMIC(yypos, yypos));
<INITIAL>"!" => (NOT(yypos, yypos));
<INITIAL>"," => (COMMA(yypos, yypos));
<INITIAL>{startcomment} => (YYBEGIN COMMENT; lex());
<COMMENT>{endcomment} => (YYBEGIN INITIAL; lex());
<COMMENT>. => (lex());
<INITIAL>. => (error ("\n ***Lexer error: bad character ***\n"); 
	raise Fail("Lexer error: bad character " ^ yytext));


