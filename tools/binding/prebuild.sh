#!/bin/sh

g++ llvm-ext.cpp -c `llvm-config --cflags`
g++ llvm-opt.cpp -c `llvm-config --cflags`
g++ llvm-typemonitor.cpp -c `llvm-config --cflags`

rm -f libllvm-c-ext.a
ar rc libllvm-c-ext.a llvm-ext.o llvm-opt.o llvm-typemonitor.o
ranlib libllvm-c-ext.a
