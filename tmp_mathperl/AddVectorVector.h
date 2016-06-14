// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__LinearAlgebra__AddVectorVector_h
#define __CPP__INCLUDED__MathPerl__LinearAlgebra__AddVectorVector_h 0.002_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include "MathPerl/Operation.cpp"
#include "MathPerl/DataStructure/Vector.cpp"
//#include "MathPerl/DataStructure/VectorBound.cpp"
//#include "MathPerl/DataStructure/Vector3D.cpp"
//#include "MathPerl/DataStructure/Vector3DBound.cpp"
#include "MathPerl/Arithmetic/ApproximatelyEqual.cpp"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MathPerl__LinearAlgebra__AddVectorVector : public MathPerl__Operation {
public:
    // [[[ OO METHODS ]]]

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__LinearAlgebra__AddVectorVector() {}
    ~MathPerl__LinearAlgebra__AddVectorVector() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::LinearAlgebra::AddVectorVector"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__LinearAlgebra__AddVectorVector_rawptr MathPerl__LinearAlgebra__AddVectorVector*
typedef std::unique_ptr<MathPerl__LinearAlgebra__AddVectorVector> MathPerl__LinearAlgebra__AddVectorVector_ptr;
typedef std::vector<MathPerl__LinearAlgebra__AddVectorVector_ptr> MathPerl__LinearAlgebra__AddVectorVector_arrayref;
typedef std::unordered_map<string, MathPerl__LinearAlgebra__AddVectorVector_ptr> MathPerl__LinearAlgebra__AddVectorVector_hashref;
typedef std::unordered_map<string, MathPerl__LinearAlgebra__AddVectorVector_ptr>::iterator MathPerl__LinearAlgebra__AddVectorVector_hashref_iterator;

// [[[ SUBROUTINES ]]]
//MathPerl__DataStructure__Vector3DBound_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_3d_bound_vector_3d_bound(MathPerl__DataStructure__Vector3DBound input_0, MathPerl__DataStructure__Vector3DBound input_1);
//MathPerl__DataStructure__Vector3D_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector3d_vector3d(MathPerl__DataStructure__Vector3D input_0, MathPerl__DataStructure__Vector3D input_1);
//MathPerl__DataStructure__VectorBound_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_bound_vector_bound(MathPerl__DataStructure__VectorBound input_0, MathPerl__DataStructure__VectorBound input_1);
MathPerl__DataStructure__Vector_rawptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector(MathPerl__DataStructure__Vector_rawptr input_0, MathPerl__DataStructure__Vector_rawptr input_1, const char* CLASS);
number_arrayref MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw(number_arrayref input_0, number_arrayref input_1);

// <<< SHIM MACROS >>>
#define add_vector_3d_bound_vector_3d_bound(input_0, input_1) MathPerl__LinearAlgebra__AddVectorVector__add_vector_3d_bound_vector_3d_bound(input_0, input_1)
#define add_vector3d_vector3d(input_0, input_1) MathPerl__LinearAlgebra__AddVectorVector__add_vector3d_vector3d(input_0, input_1)
#define add_vector_bound_vector_bound(input_0, input_1) MathPerl__LinearAlgebra__AddVectorVector__add_vector_bound_vector_bound(input_0, input_1)
#define add_vector_vector(input_0, input_1) MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector(input_0, input_1)
#define add_vector_vector_raw(input_0, input_1) MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw(input_0, input_1)

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__LinearAlgebra__AddVectorVector__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
