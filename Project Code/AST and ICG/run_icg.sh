#!/bin/bash

lex icg.l
yacc -d icg.y
gcc lex.yy.c y.tab.c -ll
./a.out < t2.c
