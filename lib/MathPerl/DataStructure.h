// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__DataStructure_h
#define __CPP__INCLUDED__MathPerl__DataStructure_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include <RPerl/CompileUnit/Module/Class.cpp>

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MathPerl__DataStructure : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO METHODS ]]]

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__DataStructure() {}
    ~MathPerl__DataStructure() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::DataStructure"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__DataStructure_rawptr MathPerl__DataStructure*
typedef std::unique_ptr<MathPerl__DataStructure> MathPerl__DataStructure_ptr;
typedef std::vector<MathPerl__DataStructure_ptr> MathPerl__DataStructure_arrayref;
typedef std::unordered_map<string, MathPerl__DataStructure_ptr> MathPerl__DataStructure_hashref;
typedef std::unordered_map<string, MathPerl__DataStructure_ptr>::iterator MathPerl__DataStructure_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__DataStructure__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
