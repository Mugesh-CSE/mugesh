%{
#include <tac.tab.h>
#include <string.h>
#include <stdlib.h>

extern YYSTYPE yylval;
%}

%%
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
[0-9]+                 { yylval.str = strdup(yytext); return NUM; }
[ \t]+                 ;       // skip spaces and tabs
\n                     ;       // skip newlines (optional: track line count)
.                      { return yytext[0]; } // return single char tokens
%%

int yywrap() { 
	return 1; 
}
