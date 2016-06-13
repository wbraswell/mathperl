// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__DataStructure__Vector3D_h
#define __CPP__INCLUDED__MathPerl__DataStructure__Vector3D_h 0.001_000

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
class MathPerl__DataStructure__Vector3D : public MathPerl__DataStructure__Vector {
public:
    // [[[ OO PROPERTIES ]]]
    number x = 0;
    number y = 0;
    number z = 0;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    number get_x() { return this->x; }
    void set_x(number x_new) { this->x = x_new; }
    number get_y() { return this->y; }
    void set_y(number y_new) { this->y = y_new; }
    number get_z() { return this->z; }
    void set_z(number z_new) { this->z = z_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__DataStructure__Vector3D() {}
    ~MathPerl__DataStructure__Vector3D() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::DataStructure::Vector3D"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__DataStructure__Vector3D_rawptr MathPerl__DataStructure__Vector3D*
typedef std::unique_ptr<MathPerl__DataStructure__Vector3D> MathPerl__DataStructure__Vector3D_ptr;
typedef std::vector<MathPerl__DataStructure__Vector3D_ptr> MathPerl__DataStructure__Vector3D_arrayref;
typedef std::unordered_map<string, MathPerl__DataStructure__Vector3D_ptr> MathPerl__DataStructure__Vector3D_hashref;
typedef std::unordered_map<string, MathPerl__DataStructure__Vector3D_ptr>::iterator MathPerl__DataStructure__Vector3D_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__DataStructure__Vector3D__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
