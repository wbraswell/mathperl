// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__Arithmetic__ApproximatelyEqual_h
#define __CPP__INCLUDED__MathPerl__Arithmetic__ApproximatelyEqual_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include "MathPerl/Operation.cpp"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MathPerl__Arithmetic__ApproximatelyEqual : public MathPerl__Operation {
public:
    // [[[ OO METHODS ]]]

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__Arithmetic__ApproximatelyEqual() {}
    ~MathPerl__Arithmetic__ApproximatelyEqual() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::Arithmetic::ApproximatelyEqual"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__Arithmetic__ApproximatelyEqual_rawptr MathPerl__Arithmetic__ApproximatelyEqual*
typedef std::unique_ptr<MathPerl__Arithmetic__ApproximatelyEqual> MathPerl__Arithmetic__ApproximatelyEqual_ptr;
typedef std::vector<MathPerl__Arithmetic__ApproximatelyEqual_ptr> MathPerl__Arithmetic__ApproximatelyEqual_arrayref;
typedef std::unordered_map<string, MathPerl__Arithmetic__ApproximatelyEqual_ptr> MathPerl__Arithmetic__ApproximatelyEqual_hashref;
typedef std::unordered_map<string, MathPerl__Arithmetic__ApproximatelyEqual_ptr>::iterator MathPerl__Arithmetic__ApproximatelyEqual_hashref_iterator;

// [[[ SUBROUTINES ]]]
boolean MathPerl__Arithmetic__ApproximatelyEqual__approximately_equal(number input_0, number input_1);

// <<< SHIM MACROS >>>
#define approximately_equal(input_0, input_1) MathPerl__Arithmetic__ApproximatelyEqual__approximately_equal(input_0, input_1)

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__Arithmetic__ApproximatelyEqual__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
