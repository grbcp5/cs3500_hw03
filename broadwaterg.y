%{
 
#include <iostream>
#include <stdio.h>

int numLines = 1;

void printRule(const char *lhs, const char *rhs);
int yyerror(const char *s);
void printTokenInfo(const char* tokenType, const char* lexeme);

extern "C" {
  int yyparse( void );
  int yylex( void );
  int yywrap() {
    return 1;
  }  
}

%}

/* Tokens */
%token LETSTAR
%token LAMBDA 

%token INPUT 
%token PRINT 

%token IF

%token LPAREN
%token RPAREN

%token ADD
%token MULT
%token DIV
%token SUB

%token AND
%token OR
%token NOT

%token LT
%token GT
%token LE
%token GE
%token EQ
%token NE

%token IDENT
%token INTCONST
%token STRCONST

%token COMMENT
%token T
%token NIL
%token WS
%token UNKNOWN

/* Start */
%start START

/* Rules */
%%

START : EXPR {
  printRule ("START", "EXPR");
  printf( "\n---- Completed parsing ----\n\n" );
  return 0;
}

EXPR : CONST {
  printRule( "EXPR", "CONST" );
} | IDENT {
  printRule( "EXPR", "IDENT" );
} | LPAREN PARENTHESIZED_EXPR RPAREN {
  printRule( "EXPR", "( PARENTHESIZED_EXPR )" );
}

CONST : INTCONST {
  printRule( "CONST", "INTCONST" );
} | STRCONST {
  printRule( "CONST", "STRCONST" );
} | T {
  printRule( "CONST", "T" );
} | NIL {
  printRule( "CONST", "NIL" );
}

PARENTHESIZED_EXPR : ARITHLOGIC_EXPR {
  printRule( "PARENTHESIZED_EXPR", "ARITHLOGIC_EXPR" );
} | IF_EXPR {
  printRule( "PARENTHESIZED_EXPR", "IF_EXPR" );
} | LET_EXPR {
  printRule( "PARENTHESIZED_EXPR", "LET_EXPR" );
} | LAMBDA_EXPR {
  printRule( "PARENTHESIZED_EXPR", "LAMBDA_EXPR" );
} | PRINT_EXPR {
  printRule( "PARENTHESIZED_EXPR", "PRINT_EXPR" );
} | INPUT_EXPR {
  printRule( "PARENTHESIZED_EXPR", "INPUT_EXPR" );
} | EXPR_LIST {
  printRule( "PARENTHESIZED_EXPR", "EXPR_LIST" );
}

ARITHLOGIC_EXPR : UN_OP EXPR {
  printRule( "ARITHLOGIC_EXPR", "UN_OP EXPR" );
} | BIN_OP EXPR EXPR {
  printRule( "ARITHLOGIC_EXPR", "BIN_OP EXPR EXPR" );
}

IF_EXPR : IF EXPR EXPR EXPR {
  printRule( "IF_EXPR", "IF EXPR EXPR EXPR" );
}

LET_EXPR : LETSTAR LPAREN ID_EXPR_LIST RPAREN EXPR {
  printRule( "LET_EXPR", "let* ( ID_EXPR_LIST ) EXPR" );
}

ID_EXPR_LIST : /* epsilon */ {
  printRule( "ID_EXPR_LIST", "EPSILON" );
} | ID_EXPR_LIST LPAREN IDENT EXPR RPAREN {
  printRule( "ID_EXPR_LIST", "ID_EXPR_LIST ( IDENT EXPR ) " );
}

LAMBDA_EXPR : LAMBDA LPAREN ID_LIST RPAREN EXPR {
  printRule( "LAMBDA_EXPR", "LAMBDA ( ID_LIST ) EXPR" );
}

ID_LIST : /* epsilon */ {
  printRule( "ID_LIST", "EPSILON" );
} | ID_LIST IDENT {
  printRule( "ID_LIST", "ID_LIST IDENT" );
}

PRINT_EXPR : PRINT EXPR {
  printRule( "PRINT_EXPR", "PRINT EXPR" );
}

INPUT_EXPR : INPUT {
  printRule( "INPUT_EXPR", "INPUT" );
}

EXPR_LIST : EXPR EXPR_LIST {
  printRule( "EXPR_LIST", "EXPR EXPR_LIST" );
} | EXPR {
  printRule( "EXPR_LIST", "EXPR" );
}

BIN_OP : ARITH_OP {
  printRule( "BIN_OP", "ARITH_OP" );
} | LOG_OP {
  printRule( "BIN_OP", "LOG_OP" );
} | REL_OP {
  printRule( "BIN_OP", "REL_OP" );
}

ARITH_OP : MULT {
  printRule( "ARITH_OP", "*" );
} | SUB {
  printRule( "ARITH_OP", "-" );
} | DIV {
  printRule( "ARITH_OP", "/" );
} | ADD {
  printRule( "ARITH_OP", "+" );
}

LOG_OP : AND {
  printRule( "LOG_OP", "and" );
} | OR {
  printRule( "LOG_OP", "or" );
}

REL_OP : LT {
  printRule( "REL_OP", "<" );
} | GT {
  printRule( "REL_OP", ">" );
} | LE {
  printRule( "REL_OP", "<=" );
} | GE {
  printRule( "REL_OP", ">=" );
} | EQ {
  printRule( "REL_OP", "=" );
} | NE {
  printRule( "REL_OP", "/=" );
}

UN_OP : NOT {
  printRule( "UN_OP", "not" );
} 

%%

#include "lex.yy.c"

void printRule(const char *lhs, const char *rhs) {
  printf("%s -> %s\n", lhs, rhs);
  return;
}

int yyerror(const char *s) {
  printf("Line %d: %s\n", numLines, s);
return(1);
}

void printTokenInfo(const char* tokenType, const char* lexeme) {
  printf("TOKEN: %-8s  LEXEME: %s\n", tokenType, lexeme);
}

int main() {

  do {
    yyparse();
  } while (!feof(yyin));

  return 0;
}