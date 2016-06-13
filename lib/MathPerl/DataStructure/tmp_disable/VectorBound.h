// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__DataStructure__VectorBound_h
#define __CPP__INCLUDED__MathPerl__DataStructure__VectorBound_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include "MathPerl/DataStructure.cpp"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MathPerl__DataStructure__VectorBound : public MathPerl__DataStructure {
public:
    // [[[ OO PROPERTIES ]]]
    number_arrayref tail = {};
    number_arrayref head = {};

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    number_arrayref get_tail() { return this->tail; }
    void set_tail(number_arrayref tail_new) { this->tail = tail_new; }
    number_arrayref get_head() { return this->head; }
    void set_head(number_arrayref head_new) { this->head = head_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__DataStructure__VectorBound() {}
    ~MathPerl__DataStructure__VectorBound() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::DataStructure::VectorBound"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__DataStructure__VectorBound_rawptr MathPerl__DataStructure__VectorBound*
typedef std::unique_ptr<MathPerl__DataStructure__VectorBound> MathPerl__DataStructure__VectorBound_ptr;
typedef std::vector<MathPerl__DataStructure__VectorBound_ptr> MathPerl__DataStructure__VectorBound_arrayref;
typedef std::unordered_map<string, MathPerl__DataStructure__VectorBound_ptr> MathPerl__DataStructure__VectorBound_hashref;
typedef std::unordered_map<string, MathPerl__DataStructure__VectorBound_ptr>::iterator MathPerl__DataStructure__VectorBound_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__DataStructure__VectorBound__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
