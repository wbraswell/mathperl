#include <omp.h>
#include <math.h>
#define ceild(n,d)  ceil(((double)(n))/((double)(d)))
#define floord(n,d) floor(((double)(n))/((double)(d)))
#define polyccmax(x,y)    ((x) > (y)? (x) : (y))
#define polyccmin(x,y)    ((x) < (y)? (x) : (y))

//!/usr/bin/rperl
// [[[ HEADER ]]]
#include <rperlstandalone.h>
#ifndef __CPP__INCLUDED__MathPerl__LinearAlgebra__gauss_seidel_cpp
#define __CPP__INCLUDED__MathPerl__LinearAlgebra__gauss_seidel_cpp 0.001_000
# ifdef __CPP__TYPES



int main() {
    // [[[ OPERATIONS HEADER ]]]
    integer i;
    integer j;
    integer t;

// [[[ OPERATIONS ]]]
    const integer t_big = 5;
    const integer n_big = 10;
    number_arrayref_arrayref arr(n_big, number_arrayref(n_big));
    for ( i = 0; i < n_big; i++ ) {
        for ( j = 0; j < n_big; j++ ) {
            arr[i][j] = i * i + j * j;
        }
    }
/* Copyright (C) 1991-2014 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */
/* This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include <features.h> or any other header that includes
   <features.h> because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  */
/* glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to deterpolyccmine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  */
/* wchar_t uses ISO/IEC 10646 (2nd ed., published 2011-03-15) /
   Unicode 6.0.  */
/* We do not support C11 <threads.h>.  */
  int t1, t2, t3, t4, t5, t6;
 int lb, ub, lbp, ubp, lb2, ub2;
 register int lbv, ubv;
/* Start of CLooG code */
if ((n_big >= 3) && (t_big >= 1)) {
  for (t1=0;t1<=floord(2*t_big+n_big-4,32);t1++) {
    lbp=polyccmax(ceild(t1,2),ceild(32*t1-t_big+1,32));
    ubp=polyccmin(polyccmin(floord(t_big+n_big-3,32),floord(32*t1+n_big+29,64)),t1);
#pragma omp parallel for private(lbv,ubv,t3,t4,t5,t6)
    for (t2=lbp;t2<=ubp;t2++) {
      for (t3=polyccmax(ceild(64*t2-n_big-28,32),t1);t3<=polyccmin(polyccmin(polyccmin(polyccmin(floord(t_big+n_big-3,16),floord(32*t1-32*t2+n_big+29,16)),floord(32*t1+n_big+60,32)),floord(64*t2+n_big+59,32)),floord(32*t2+t_big+n_big+28,32));t3++) {
        for (t4=polyccmax(polyccmax(polyccmax(32*t1-32*t2,32*t2-n_big+2),16*t3-n_big+2),-32*t2+32*t3-n_big-29);t4<=polyccmin(polyccmin(polyccmin(polyccmin(32*t2+30,16*t3+14),t_big-1),32*t1-32*t2+31),-32*t2+32*t3+30);t4++) {
          for (t5=polyccmax(polyccmax(32*t2,t4+1),32*t3-t4-n_big+2);t5<=polyccmin(polyccmin(32*t2+31,32*t3-t4+30),t4+n_big-2);t5++) {
            for (t6=polyccmax(32*t3,t4+t5+1);t6<=polyccmin(32*t3+31,t4+t5+n_big-2);t6++) {
              arr[(-t4+t5)][(-t4-t5+t6)] = (arr[(-t4+t5) - 1][(-t4-t5+t6) - 1] + arr[(-t4+t5) - 1][(-t4-t5+t6)] + arr[(-t4+t5) - 1][(-t4-t5+t6) + 1] + arr[(-t4+t5)][(-t4-t5+t6) - 1] + arr[(-t4+t5)][(-t4-t5+t6)] + arr[(-t4+t5)][(-t4-t5+t6) + 1] + arr[(-t4+t5) + 1][(-t4-t5+t6) - 1] + arr[(-t4+t5) + 1][(-t4-t5+t6)] + arr[(-t4+t5) + 1][(-t4-t5+t6) + 1]) / 9.0;;
            }
          }
        }
      }
    }
  }
}
/* End of CLooG code */
    print "Have final answer, final element $arr->[" << (n_big - 2) << "]->[" << (n_big - 2) << "] = " << arr[(n_big - 2)][(n_big - 2)] << endl;



    // [[[ OPERATIONS FOOTER ]]]
    return 0;
}

// [[[ FOOTER ]]]
# elif defined __PERL__TYPES
Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!
# endif
#endif
