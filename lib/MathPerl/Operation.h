// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MathPerl__Operation_h
#define __CPP__INCLUDED__MathPerl__Operation_h 0.001_000

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
class MathPerl__Operation : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO METHODS ]]]

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MathPerl__Operation() {}
    ~MathPerl__Operation() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MathPerl::Operation"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MathPerl__Operation_rawptr MathPerl__Operation*
typedef std::unique_ptr<MathPerl__Operation> MathPerl__Operation_ptr;
typedef std::vector<MathPerl__Operation_ptr> MathPerl__Operation_arrayref;
typedef std::unordered_map<string, MathPerl__Operation_ptr> MathPerl__Operation_hashref;
typedef std::unordered_map<string, MathPerl__Operation_ptr>::iterator MathPerl__Operation_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MathPerl__Operation__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
