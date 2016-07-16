#!/bin/bash

rperl -V -D lib/MathPerl/LinearAlgebra/gauss_seidel.pl

polycc lib/MathPerl/LinearAlgebra/gauss_seidel.cpp -o lib/MathPerl/LinearAlgebra/gauss_seidel.openmp.cpp --parallel --tile

g++ -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib" -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -D__TYPE__INTEGER__LONG -D__TYPE__NUMBER__DOUBLE -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE"    -mtune=native -ftree-vectorize -DTIME -fopenmp lib/MathPerl/LinearAlgebra/gauss_seidel.openmp.cpp -o lib/MathPerl/LinearAlgebra/gauss_seidel.openmp -lm -lperl
