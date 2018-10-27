#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '[ 0, 2, 4, 6, 8 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 1, 3, 5, 7, 9 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 1, 5, 9, 13, 17 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 1, 5, 9, 13, 17 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 1, 5, 9, 13, 17 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 1, 5, 9, 13, 17 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 0, 5, 10, 15, 20, 25, 30, 35 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 0, 5, 10, 15, 20, 25, 30, 35 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 0, 5, 10, 15, 20, 25, 30, 35 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 0, 5, 10, 15, 20, 25, 30, 35 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 0, 4, 8, 12, 16 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 2, 6, 10, 14, 18 ]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.004_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::Vector;
use MathPerl::LinearAlgebra::AddVectorVector;

# [[[ OPERATIONS ]]]

print 'have MathPerl__DataStructure__Vector__MODE_ID() = ' . MathPerl__DataStructure__Vector__MODE_ID() . "\n\n";

# START HERE: shorthand class, C++ generate for die() & croak(), tests for other vector additions, CPPOPS_CPTYPES generate & execute tests, vector-scalar-mult & tests, cross product & tests, dot product & tests
# START HERE: shorthand class, C++ generate for die() & croak(), tests for other vector additions, CPPOPS_CPTYPES generate & execute tests, vector-scalar-mult & tests, cross product & tests, dot product & tests
# START HERE: shorthand class, C++ generate for die() & croak(), tests for other vector additions, CPPOPS_CPTYPES generate & execute tests, vector-scalar-mult & tests, cross product & tests, dot product & tests

# DEV NOTE: prefer shorthand classes in user code, Vector instead of MathPerl::DataStructure::Vector
#my MathPerl::DataStructure::Vector $input_vector_0 = MathPerl::DataStructure::Vector->new();
#my MathPerl::DataStructure::Vector $input_vector_1 = MathPerl::DataStructure::Vector->new();
#my MathPerl::DataStructure::Vector $retval_vector;
my Vector $input_vector_0 = Vector->new();
my Vector $input_vector_1 = Vector->new();
my Vector $retval_vector;

# [[[ object AKA not raw ]]]

# NEED UPGRADE: currently require OO property encapsulation via accessors/mutators when operating in C++ modes
#$input_vector_0->{head} = [0, 2, 4, 6, 8];
#$input_vector_1->{head} = [1, 3, 5, 7, 9];
$input_vector_0->set_head([0, 2, 4, 6, 8]);
$input_vector_1->set_head([1, 3, 5, 7, 9]);

# NEED UPGRADE: currently require objects to be created by C++ constructor when operating in C++ modes, can not use objects created by Perl bless() constructor in C++ modes
#my arrayref_hashref $manual_perl_vector = {head => [2.1, 3.2, 4.3]};
#bless $manual_perl_vector, 'MathPerl::DataStucture::Vector';
#print 'have Dumper($manual_perl_vector) = ' . "\n" . Dumper($manual_perl_vector) . "\n\n";
#print 'have MathPerl__DataStructure__Vector__::Vector_to_string( $manual_perl_vector ) = ' . q{'} . 
#    MathPerl__DataStructure__Vector__::Vector_to_string( $manual_perl_vector ) . q{'} . "\n\n";
#    MathPerl::DataStructure::Vector::Vector_to_string( $manual_perl_vector ) . q{'} . "\n\n";

#print 'have Dumper($input_vector_0) = ' . "\n" . Dumper($input_vector_0) . "\n\n";
#print 'have Dumper($input_vector_0->get_head()) = ' . "\n" . Dumper($input_vector_0->get_head()) . "\n\n";
#print 'have Dumper($input_vector_1->get_head()) = ' . "\n" . Dumper($input_vector_1->get_head()) . "\n\n";

print 'have ::Vector_to_string($input_vector_0) = ' . "\n" . ::Vector_to_string($input_vector_0) . "\n\n";
print 'have ::Vector_to_string($input_vector_1) = ' . "\n" . ::Vector_to_string($input_vector_1) . "\n\n";

$retval_vector = MathPerl::LinearAlgebra::AddVectorVector::add_vector_vector( $input_vector_0, $input_vector_1 );

#print 'have Dumper($retval_vector) = ' . "\n" . Dumper($retval_vector) . "\n\n";
print 'have number_arrayref_to_string($retval_vector->get_head()) = ' . "\n" . number_arrayref_to_string($retval_vector->get_head()) . "\n\n";
print 'have ::Vector_to_string($retval_vector) = ' . "\n" . ::Vector_to_string($retval_vector) . "\n\n";
print 'have MathPerl::DataStructure::Vector::Vector_to_string($retval_vector) = ' . "\n" . MathPerl::DataStructure::Vector::Vector_to_string($retval_vector) . "\n\n";
print 'have $retval_vector->To_string() = ' . "\n" . $retval_vector->To_string() . "\n\n";

$retval_vector = MathPerl::DataStructure::Vector::test_constructor(8);

#print 'have Dumper($retval_vector) = ' . "\n" . Dumper($retval_vector) . "\n\n";
print 'have number_arrayref_to_string($retval_vector->get_head()) = ' . "\n" . number_arrayref_to_string($retval_vector->get_head()) . "\n\n";
print 'have ::Vector_to_string($retval_vector) = ' . "\n" . ::Vector_to_string($retval_vector) . "\n\n";
print 'have MathPerl::DataStructure::Vector::Vector_to_string($retval_vector) = ' . "\n" . MathPerl::DataStructure::Vector::Vector_to_string($retval_vector) . "\n\n";
print 'have $retval_vector->To_string() = ' . "\n" . $retval_vector->To_string() . "\n\n";

# [[[ number_arrayref AKA raw ]]]

my number_arrayref $retval_vector_raw;
$retval_vector_raw = MathPerl::LinearAlgebra::AddVectorVector::add_vector_vector_raw( $input_vector_0->get_head(), $input_vector_0->get_head() );
print 'have number_arrayref_to_string($retval_vector_raw) = ' . "\n" . number_arrayref_to_string($retval_vector_raw) . "\n\n";
$retval_vector_raw = MathPerl::LinearAlgebra::AddVectorVector::add_vector_vector_raw( $input_vector_1->get_head(), $input_vector_1->get_head() );
print 'have number_arrayref_to_string($retval_vector_raw) = ' . "\n" . number_arrayref_to_string($retval_vector_raw) . "\n\n";
