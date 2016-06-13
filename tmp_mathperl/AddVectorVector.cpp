// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__LinearAlgebra__AddVectorVector_cpp
#define __CPP__INCLUDED__MathPerl__LinearAlgebra__AddVectorVector_cpp 0.002_000

// [[[ INCLUDES ]]]
#include "MathPerl/LinearAlgebra/AddVectorVector.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO METHODS & SUBROUTINES ]]]

/*
MathPerl__DataStructure__Vector3DBound_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_3d_bound_vector_3d_bound(MathPerl__DataStructure__Vector3DBound input_0, MathPerl__DataStructure__Vector3DBound input_1) {
/*
    if ( not approximately_equal(input_0.tail_x, input_1.tail_x) ) {
//        die( (const string) "ERROR EMPLAADVV03: Tail value mismatch, input vector 0 tail element x contains value " + input_0.tail_x + (const string) " and input vector 1 tail element x contains value " + input_1.tail_x + (const string) ", can not add together bound vectors with unequal tails, dying" + (const string) "\n" );
    }
    if ( not approximately_equal(input_0.tail_y, input_1.tail_y) ) {
//        die( (const string) "ERROR EMPLAADVV03: Tail value mismatch, input vector 0 tail element y contains value " + input_0.tail_y + (const string) " and input vector 1 tail element y contains value " + input_1.tail_y + (const string) ", can not add together bound vectors with unequal tails, dying" + (const string) "\n" );
    }
    if ( not approximately_equal(input_0.tail_z, input_1.tail_z) ) {
//        die( (const string) "ERROR EMPLAADVV03: Tail value mismatch, input vector 0 tail element z contains value " + input_0.tail_z + (const string) " and input vector 1 tail element z contains value " + input_1.tail_z + (const string) ", can not add together bound vectors with unequal tails, dying" + (const string) "\n" );
    }
*_/

//    MathPerl__DataStructure__Vector3DBound_ptr return_value(new MathPerl__DataStructure__Vector3DBound_ptr);
//    MathPerl__DataStructure__Vector3DBound_ptr return_value = *(new MathPerl__DataStructure__Vector3DBound_ptr);
//    MathPerl__DataStructure__Vector3DBound_ptr *return_value_rawptr = new MathPerl__DataStructure__Vector3DBound_ptr;
//    MathPerl__DataStructure__Vector3DBound_ptr return_value = *return_value_rawptr;

    MathPerl__DataStructure__Vector3DBound_ptr return_value;

/*
    return_value->tail_x = input_0.tail_x;
    return_value->tail_y = input_0.tail_y;
    return_value->tail_z = input_0.tail_z;

    return_value->head_x = input_0.head_x + input_1.head_x;
    return_value->head_y = input_0.head_y + input_1.head_y;
    return_value->head_z = input_0.head_z + input_1.head_z;
*_/

    return return_value;
}
*/

MathPerl__DataStructure__Vector3D_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector3d_vector3d(MathPerl__DataStructure__Vector3D input_0, MathPerl__DataStructure__Vector3D input_1) {
    MathPerl__DataStructure__Vector3D_ptr return_value(new MathPerl__DataStructure__Vector3D);
    return_value->x = input_0.x + input_1.x;
    return_value->y = input_0.y + input_1.y;
    return_value->z = input_0.z + input_1.z;
    return return_value;
}

/*
MathPerl__DataStructure__VectorBound_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_bound_vector_bound(MathPerl__DataStructure__VectorBound input_0, MathPerl__DataStructure__VectorBound input_1) {
    integer i;
    integer input_0_tail_dimensionality = input_0.tail.size();
    integer input_1_tail_dimensionality = input_1.tail.size();
    if ( input_0_tail_dimensionality != input_1_tail_dimensionality ) {
//        die( (const string) "ERROR EMPLAADVV01: Dimensionality mismatch, input VectorBound 0 tail contains " + input_0_tail_dimensionality + (const string) " elements and input VectorBound 1 tail contains " + input_1_tail_dimensionality + (const string) " elements, dying" + (const string) "\n" );
    }
    for ( i = 0; i < input_0_tail_dimensionality; i++ ) {
        if ( not approximately_equal(input_0.tail[i], input_1.tail[i]) ) {
//            die( (const string) "ERROR EMPLAADVV02: Tail value mismatch, input VectorBound 0 tail element " + i + (const string) " contains value " + input_0.tail[i] + (const string) " and input VectorBound 1 tail element " + i + (const string) " contains value " + input_1.tail[i] + (const string) ", can not add together bound vectors with unequal tails, dying" + (const string) "\n" );
        }
    }
    MathPerl__DataStructure__VectorBound_ptr return_value(new MathPerl__DataStructure__VectorBound);
    return_value->tail = input_0.tail;
    return_value->head = add_vector_vector_raw(input_0.head, input_1.head);
    return return_value;
}
*/

MathPerl__DataStructure__Vector_ptr MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector(MathPerl__DataStructure__Vector input_0, MathPerl__DataStructure__Vector input_1) {
    MathPerl__DataStructure__Vector_ptr return_value(new MathPerl__DataStructure__Vector);
    return_value->head = add_vector_vector_raw(input_0.head, input_1.head);
    return return_value;
}

number_arrayref MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw(number_arrayref input_0, number_arrayref input_1) {
    integer i;
    integer input_0_dimensionality = input_0.size();
    integer input_1_dimensionality = input_1.size();
    if ( input_0_dimensionality != input_0_dimensionality ) {
//        die( (const string) "ERROR EMPLAADVV00: Dimensionality mismatch, input Vector 0 raw number_arrayref contains " + input_0_dimensionality + (const string) " elements and input Vector 1 raw number_arrayref contains " + input_1_dimensionality + (const string) " elements, dying" + (const string) "\n" );
    }
    number_arrayref return_value = {};
    for ( i = 0; i < input_0_dimensionality; i++ ) {
        return_value[i] = input_0[i] + input_1[i];
    }
    return return_value;
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
