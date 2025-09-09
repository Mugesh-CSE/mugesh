%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
char* newTemp() {
    char buffer[20];
    sprintf(buffer, "t%d", tempCount++);
    return strdup(buffer);
}

void yyerror(const char* s);
int yylex(void);

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
        free($1);
        free($3);
    }
    ;

expr:
      expr '+' term {
          char* temp = newTemp();
          printf("%s = %s + %s\n", temp, $1, $3);
          free($1);
          free($3);
          $$ = temp;
      }
    | expr '-' term {
          char* temp = newTemp();
          printf("%s = %s - %s\n", temp, $1, $3);
          free($1);
          free($3);
          $$ = temp;
      }
    | term {
          $$ = $1;
      }
    ;

term:
      term '*' factor {
          char* temp = newTemp();
          printf("%s = %s * %s\n", temp, $1, $3);
          free($1);
          free($3);
          $$ = temp;
      }
    | term '/' factor {
          char* temp = newTemp();
          printf("%s = %s / %s\n", temp, $1, $3);
          free($1);
          free($3);
          $$ = temp;
      }
    | factor {
          $$ = $1;
      }
    ;

factor:
      ID {
          $$ = $1;
      }
    | NUM {
          $$ = $1;
      }
    | '(' expr ')' {
          $$ = $2;
      }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter an expression like:\n");
    printf("a = b + c * d;\n");
    yyparse();
    return 0;
}
