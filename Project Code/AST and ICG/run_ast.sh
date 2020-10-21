#!/bin/bash

lex ast.l
yacc -d ast.y
gcc lex.yy.c y.tab.c -ll
./a.out < t1.c
