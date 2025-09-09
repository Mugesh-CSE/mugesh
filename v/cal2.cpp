%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char* s);
int tempCount = 1;
char result[10];
char* newTemp() {
sprintf(result, "t%d", tempCount++);
return strdup(result);
}
%}
%union {
char* str;
}
%token <str> ID
%token <str> NUM
%type <str> expr term factor
%left '+' '-'
%left '*' '/'
%%
stmt:
ID '=' expr ';' {
printf("%s = %s\n", $1, $3);
}
;
expr:
expr '+' term {
char* temp = newTemp();
printf("%s = %s + %s\n", temp, $1, $3);
$$ = temp;
}



| expr '-' term {
char* temp = newTemp();
printf("%s = %s - %s\n", temp, $1, $3);
$$ = temp;
}
| term { $$ = $1; }
;
term:
term '*' factor {
char* temp = newTemp();
printf("%s = %s * %s\n", temp, $1, $3);
$$ = temp;
}
| term '/' factor {
char* temp = newTemp();
printf("%s = %s / %s\n", temp, $1, $3);
$$ = temp;
}
| factor { $$ = $1; }
;
factor:
ID { $$ = $1; }
| NUM { $$ = $1; }
| '(' expr ')' { $$ = $2; }
;
%%
void yyerror(const char* s) {
fprintf(stderr, "Error: %s\n", s);
}
int main() {
printf("Enter expression like: a = b + c * d;\n");
yyparse();
return 0;