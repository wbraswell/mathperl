// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__DataStructure__Vector3DBound_h
#define __CPP__INCLUDED__MathPerl__DataStructure__Vector3DBound_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include "MathPerl/DataStructure/Vector.cpp"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MathPerl__DataStructure__Vector3DBound : public MathPerl__DataStructure__Vector {
public:
    // [[[ OO PROPERTIES ]]]
    number tail_x = 0;
    number tail_y = 0;
    number tail_z = 0;
    number head_x = 0;
    number head_y = 0;
    number head_z = 0;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    number get_tail_x() { return this->tail_x; }
    void set_tail_x(number tail_x_new) { this->tail_x = tail_x_new; }
    number get_tail_y() { return this->tail_y; }
    void set_tail_y(number tail_y_new) { this->tail_y = tail_y_new; }
    number get_tail_z() { return this->tail_z; }
    void set_tail_z(number tail_z_new) { this->tail_z = tail_z_new; }
    number get_head_x() { return this->head_x; }
    void set_head_x(number head_x_new) { this->head_x = head_x_new; }
    number get_head_y() { return this->head_y; }
    void set_head_y(number head_y_new) { this->head_y = head_y_new; }
    number get_head_z() { return this->head_z; }
    void set_head_z(number head_z_new) { this->head_z = head_z_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__DataStructure__Vector3DBound() {}
    ~MathPerl__DataStructure__Vector3DBound() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::DataStructure::Vector3DBound"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__DataStructure__Vector3DBound_rawptr MathPerl__DataStructure__Vector3DBound*
typedef std::unique_ptr<MathPerl__DataStructure__Vector3DBound> MathPerl__DataStructure__Vector3DBound_ptr;
typedef std::vector<MathPerl__DataStructure__Vector3DBound_ptr> MathPerl__DataStructure__Vector3DBound_arrayref;
typedef std::unordered_map<string, MathPerl__DataStructure__Vector3DBound_ptr> MathPerl__DataStructure__Vector3DBound_hashref;
typedef std::unordered_map<string, MathPerl__DataStructure__Vector3DBound_ptr>::iterator MathPerl__DataStructure__Vector3DBound_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__DataStructure__Vector3DBound__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
