// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__Arithmetic__ApproximatelyEqual_cpp
#define __CPP__INCLUDED__MathPerl__Arithmetic__ApproximatelyEqual_cpp 0.001_000

// [[[ INCLUDES ]]]
#include "/home/wbraswell/austin_perl_mongers/mathperl/mathperl-latest/lib/MathPerl/Arithmetic/ApproximatelyEqual.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO METHODS & SUBROUTINES ]]]

boolean MathPerl__Arithmetic__ApproximatelyEqual__approximately_equal(number input_0, number input_1) {
    if ((abs (input_0 - input_1)) <= RPerl__EPSILON ) {
        return 1;
    }
    else {
        return 0;
    }
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
