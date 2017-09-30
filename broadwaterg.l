/*****************************************************************************
 *  
 * File:
 *   broadwaterg.l
 *
 * Author:
 *   Grant R. Broadwater
 *   12425712
 *   grbcp5
 *
 * Description:
 *   Homework submission for Homework 2 by Grant Broadwater.
 *  
 * Run:
 *   To create the lexical analyzer:
 *
 *   flex broadwaterg.l
 *   g++ lex.yy.c -o lexer
 *   lexer < inputFileName
 *
 ******************************************************************************/

%{

%}

/* Defintions of regular expressions go here */

WSPACE		    [ \t\v\r]+
NEWLINE       \n

DIGIT         [0-9]
LETTER        [a-zA-Z]
UNDERSCORE     _

IDENT			    ({LETTER}|{UNDERSCORE})({LETTER}|{DIGIT}|{UNDERSCORE})* 
INTCONST      (\+|-)?{DIGIT}+
STRCONST      \".*\"

LETSTAR       "let*"
IF            "if"
LAMBDA        "lambda"
PRINT         "print"
INPUT         "input"

AND           "and"
OR            "or"
NOT           "not"
T             "t"
NIL           "nil"

ADD           \+
SUB           -
MULT          \*
DIV           \/

LT            <
GT            >
LE            <=
GE            >=
EQ            =
NE            \/=

LPAREN        \(
RPAREN        \)

COMMENT       ;.*


%%

{INTCONST} {
	printTokenInfo( "INTCONST", yytext );
	return INTCONST;
}

{STRCONST} {
  printTokenInfo( "STRCONST", yytext );
  return STRCONST;
}

{LETSTAR} {
  printTokenInfo( "LETSTAR", yytext );
 beginScope();
  return LETSTAR;
}

{IF} {
  printTokenInfo( "IF", yytext );
  return IF;
}

{LAMBDA} {
  printTokenInfo( "LAMBDA", yytext );
  beginScope();
  return LAMBDA;
}

{PRINT} {
  printTokenInfo( "PRINT", yytext );
  return PRINT;
}

{INPUT} {
  printTokenInfo( "INPUT", yytext );
  return INPUT;
}

{AND} {
  printTokenInfo( "AND", yytext );
  return AND;
}

{OR} {
  printTokenInfo( "OR", yytext );
  return OR;
}

{NOT} {
  printTokenInfo( "NOT", yytext );
  return NOT;
}

{ADD} {
  printTokenInfo( "ADD", yytext );
  return ADD;
}

{SUB} {
  printTokenInfo( "SUB", yytext );
  return SUB;
}

{MULT} {
  printTokenInfo( "MULT", yytext );
  return MULT;
}

{DIV} {
  printTokenInfo( "DIV", yytext );
  return DIV;
}

{EQ} {
  printTokenInfo( "EQ", yytext );
  return EQ;
}

{NE} {
  printTokenInfo( "NE", yytext );
  return NE;
}

{LT} {
  printTokenInfo( "LT", yytext );
  return LT;
}

{GT} {
  printTokenInfo( "GT", yytext );
  return GT;
}

{LE} {
  printTokenInfo( "LE", yytext );
  return LE;
}

{GE} {
  printTokenInfo( "GE", yytext );
  return GE;
}

{T} {
  printTokenInfo( "T", yytext );
  return T;
}

{NIL} {
  printTokenInfo( "NIL", yytext );
  return NIL;
}

{LPAREN} {
  printTokenInfo( "LPAREN", yytext );
  return LPAREN;
}

{RPAREN} {
  printTokenInfo( "RPAREN", yytext );
  return RPAREN;
}

{IDENT} {
  yylval.text = strdup( yytext );

  printTokenInfo( "IDENT", yytext );
  return IDENT;
}

{COMMENT} {
  /* Do nothing for comment */
}

{NEWLINE} {
  numLines++;
}

{WSPACE} {

}

. {
  printTokenInfo( "UNKNOWN", yytext );
  return UNKNOWN;
}

%%



