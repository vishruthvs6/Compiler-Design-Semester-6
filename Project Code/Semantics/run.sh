#!/bin/bash

lex sym.l
yacc -d sym.y
gcc lex.yy.c y.tab.c -ll
./a.out < input.c
