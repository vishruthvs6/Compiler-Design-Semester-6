#!/bin/bash

lex ast.l
yacc -d error.y
gcc lex.yy.c y.tab.c -ll
./a.out < error.c
