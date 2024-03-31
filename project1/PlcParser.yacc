%%

%name PlcParser

%pos int

%term VAR | 
    BOOL | 
    NAT of int | 
    INT | 
    NIL | 
    FUN | 
    TRUE | FALSE |
    LPAR | RPAR | 
    LBRACK | RBRACK | 
    LBRACE | RBRACE | 
    PLUS | MINUS | 
    MULT | DIV | 
    EQ | DIFF | 
    LESS | LESSEQ | 
    AND | 
    NOT | 
    NAME of string | 
    COLON | DCOLON |
    SEMIC | 
    IF |
    THEN | 
    ELSE | 
    MATCH | 
    WITH | 
    HD | 
    TL |
    ISE | 
    PRINT | 
    FN | 
    ARROW | 
    LAMBDA |
    REC | 
    COMMA |
    PIPE | 
    UNDER | 
    EOF | 
    END

%nonterm Prog of expr | 
    Decl of expr | 
    Expr of expr | 
    AtomExpr of expr | 
    AppExpr of expr | 
    Const of expr |
    Comps of expr list | 
    MatchExpr of (expr option * expr) list | 
    CondExpr of expr option | 
    Args of (plcType * string) list | 
    Params of (plcType * string) list | 
    TypedVar of (plcType * string) |
    Type of plcType | 
    AtomType of plcType | 
    Types of plcType list

%right SEMIC ARROW
%nonassoc IF
%left ELSE
%left AND
%left EQ DIFF
%left LESS LESSEQ
%right DCOLON
%left PLUS MINUS
%left MULT DIV
%nonassoc NOT HD TL ISE PRINT NAME
%left LBRACK

%eop EOF

%noshift EOF

%start Prog

%%

Prog : Expr (Expr) | 
       Decl (Decl)

Decl : VAR NAME EQ Expr SEMIC Prog (Let(NAME, Expr, Prog)) |
       FUN NAME Args EQ Expr SEMIC Prog (Let(NAME, makeAnon(Args, Expr), Prog)) |
       FUN REC NAME Args COLON Type EQ Expr SEMIC Prog (makeFun(NAME, Args, Type, Expr, Prog))

Expr : AtomExpr (AtomExpr) |
       AppExpr (AppExpr) |
       Expr SEMIC Expr (Prim2(";", Expr1, Expr2)) |
       IF Expr THEN Expr ELSE Expr (If(Expr1, Expr2, Expr3)) |
       MATCH Expr WITH MatchExpr(Match(Expr, MatchExpr)) |
       NOT Expr (Prim1("!", Expr)) |
       MINUS Expr (Prim1("-", Expr)) |
       HD Expr (Prim1("hd", Expr)) |
       TL Expr (Prim1("tl", Expr)) |
       ISE Expr (Prim1("ise", Expr)) | 
       PRINT Expr (Prim1("print", Expr)) |
       Expr AND Expr (Prim2("&&", Expr1, Expr2)) |
       Expr MULT Expr (Prim2("*", Expr1, Expr2)) |
       Expr DIV Expr (Prim2("/", Expr1, Expr2)) |
       Expr PLUS Expr (Prim2("+", Expr1, Expr2)) |
       Expr MINUS Expr (Prim2("-", Expr1, Expr2)) |
       Expr EQ Expr (Prim2("=", Expr1, Expr2)) |
       Expr DIFF Expr (Prim2("!=", Expr1, Expr2)) |
       Expr LESS Expr (Prim2("<", Expr1, Expr2)) |
       Expr LESSEQ Expr (Prim2("<=", Expr1, Expr2)) |
       Expr DCOLON Expr (Prim2("::", Expr1, Expr2)) |
       Expr LBRACK NAT RBRACK (Item(NAT, Expr))

AtomExpr: Const (Const) |
          NAME (Var(NAME)) |
          LBRACE Prog RBRACE (Prog) |
          LPAR Expr RPAR (Expr) |
          LPAR Comps RPAR (List(Comps)) |
          FN Args LAMBDA Expr END (makeAnon(Args, Expr))

AppExpr : AtomExpr AtomExpr (Call(AtomExpr1, AtomExpr2)) |
          AppExpr AtomExpr (Call(AppExpr, AtomExpr))

Const : TRUE (ConB(true)) |
        FALSE (ConB(false)) |
        NAT (ConI(NAT)) |
        LPAR RPAR (List[]) |
        LPAR Type LBRACK RBRACK RPAR (ESeq(Type))

Comps : Expr COMMA Expr (Expr1::Expr2::[]) |
        Expr COMMA Comps (Expr::Comps)

MatchExpr : END ([]) |
            PIPE CondExpr ARROW Expr MatchExpr ((CondExpr, Expr)::MatchExpr)

CondExpr : Expr (SOME Expr) |
           UNDER (NONE)

Args : LPAR RPAR ([]) |
       LPAR Params RPAR (Params)

Params : TypedVar (TypedVar::[]) |
         TypedVar COMMA Params (TypedVar::Params)

TypedVar : Type NAME (Type, NAME)

Type : AtomType (AtomType) | 
       LPAR Types RPAR (ListT(Types)) |
       LBRACK Type RBRACK (SeqT(Type)) |
       Type ARROW Type (FunT(Type1, Type2))

AtomType : NIL (ListT([])) |
           BOOL (BoolT) |
           INT (IntT) |
           LPAR Type RPAR (Type)

Types : Type COMMA Type (Type1::Type2::[]) |
        Type COMMA Types (Type::Types)