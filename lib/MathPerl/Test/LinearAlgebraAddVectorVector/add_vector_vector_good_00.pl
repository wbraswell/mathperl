#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '[1, 5, 9, 13, 17]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::Vector;  # NEED REMOVE: should not be needed here, due to use AddVV below
use MathPerl::LinearAlgebra::AddVectorVector;

# TMP DEBUG
print "\n\n" . 'have MathPerl__DataStructure__Vector__MODE_ID() = ' . MathPerl__DataStructure__Vector__MODE_ID() . "\n\n";

# [[[ OPERATIONS ]]]
# DEV NOTE: prefer shorthand classes in user code, Vector instead of MathPerl::DataStructure::Vector
my MathPerl::DataStructure::Vector $input_vector_0 = MathPerl::DataStructure::Vector->new();
my MathPerl::DataStructure::Vector $input_vector_1 = MathPerl::DataStructure::Vector->new();
my MathPerl::DataStructure::Vector $retval_vector;
#my Vector $input_vector_0 = Vector->new();
#my Vector $input_vector_1 = Vector->new();
#my Vector $retval_vector;


# DEV NOTE: currently require OO property encapsulation via accessors/mutators in C++ modes
#$input_vector_0->{head} = [0, 2, 4, 6, 8];
#$input_vector_1->{head} = [1, 3, 5, 7, 9];
$input_vector_0->set_head([0, 2, 4, 6, 8]);
$input_vector_1->set_head([1, 3, 5, 7, 9]);

# NEED FIX: AddVV.pmc shim should export non-OO subs to main:: instead of MathPerl::LinearAlgebra::AddVectorVector::?!?
#$retval_vector = add_vector_vector( $input_vector_0, $input_vector_1 );
#$retval_vector = MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector( $input_vector_0, $input_vector_1 );
#$retval_vector = MathPerl__LinearAlgebra__AddVectorVector::add_vector_vector( $input_vector_0, $input_vector_1 );
#$retval_vector = MathPerl::LinearAlgebra::AddVectorVector::add_vector_vector( $input_vector_0, $input_vector_1 );

print 'have Dumper($input_vector_0->get_head()) = ' . "\n" . Dumper($input_vector_0->get_head()) . "\n\n";
print 'have Dumper($input_vector_1->get_head()) = ' . "\n" . Dumper($input_vector_1->get_head()) . "\n\n";

my number_arrayref $retval_vector_raw = MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw( $input_vector_0->get_head(), $input_vector_1->get_head() );
print 'have Dumper($retval_vector_raw) = ' . "\n";
print Dumper($retval_vector_raw) . "\n\n";
die 'TMP DEBUG';

# START HERE: implement C++ generate for die(), more tests for vector addition, vector-scalar-multiplication, tests, cross product, tests, dot product, tests
# START HERE: implement C++ generate for die(), more tests for vector addition, vector-scalar-multiplication, tests, cross product, tests, dot product, tests
# START HERE: implement C++ generate for die(), more tests for vector addition, vector-scalar-multiplication, tests, cross product, tests, dot product, tests

print 'have Dumper($retval_vector) = ' . "\n";
print Dumper($retval_vector) . "\n\n";
print 'have number_arrayref_to_string($retval_vector->{head}) = ' . "\n";
print number_arrayref_to_string($retval_vector->{head}) . "\n\n";
print 'have Vector_to_string($retval_vector) = ' . "\n";
print Vector_to_string($retval_vector) . "\n\n";
print 'have $retval_vector->to_string() = ' . "\n";
print $retval_vector->to_string() . "\n";
