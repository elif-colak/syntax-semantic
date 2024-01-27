digit	[0-9]
letter	[A-Za-z]
%{
  #include <stdio.h>
  #include <string.h>
  #include "y.tab.h"
  #include <iostream>
  using namespace std;
  int linenum=1;
%}
%%

"if"	return IFRKW;
"==" return COMP;
";"	return SEMICOLON;
"(" return OP;
")" return CP;
"{" return OCB;
"}" return CCB;
"=" return EQ;


"int" return INTRSW;
"string" return STRINGRSW;

{letter}({letter}|{digit})*	{ yylval.str=strdup(yytext); return IDENTIFIER ;}
[0-9]+  { yylval.number=atoi(yytext); return INTEGER; }

\"[a-zA-Z]+\"	return STRING;
\n	{linenum++;}
[ \t]+
%%
