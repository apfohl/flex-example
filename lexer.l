%{
#include <stdio.h>
#include "gram.h"
%}

%option reentrant
%option noyywrap

%%

[a-zA-Z][a-zA-Z0-9]* return IDENTIFIER;
[0-9]+(\.[0-9]+)?    return NUMBER;
[ \t\n]              ;
"["                  return LBRACKET;
"]"                  return RBRACKET;
"("                  return LPAREN;
")"                  return RPAREN;
","                  return COMMA;
";"                  return SEMIC;
"="                  return EQ;
"+"                  return ADD;
"-"                  return SUB;
"*"                  return MULT;
"/"                  return DIV;
"|+"                 return VECADD;
"|*"                 return SCMULT;

%%

int main(int argc, char **argv)
{
  const char *input = "a = 5;\nb = 87.5;\nc = (a * b) |* [1, 2, 3, 4];";

  yyscan_t scanner;
  yylex_init(&scanner);
  YY_BUFFER_STATE bufferState = yy_scan_string(input, scanner);

  int lex_code = yylex(scanner);
  while(lex_code > 0) {
    printf("%s\n", yyget_text(scanner));
    lex_code = yylex(scanner);
  }

  yy_delete_buffer(bufferState, scanner);
  yylex_destroy(scanner);

  return 0;
}
