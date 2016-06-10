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

# [[[ INCLUDES ]]]
use MathPerl::LinearAlgebra::AddVectorVector;

# [[[ OPERATIONS ]]]
my MathPerl::DataStructure::Vector $input_vector_0 = MathPerl::DataStructure::Vector->new();
my MathPerl::DataStructure::Vector $input_vector_1 = MathPerl::DataStructure::Vector->new();
my MathPerl::DataStructure::Vector $retval_vector;

$input_vector_0->{head} = [0, 2, 4, 6, 8];
$input_vector_1->{head} = [1, 3, 5, 7, 9];
$retval_vector = add_vector_vector( $input_vector_0, $input_vector_1 );

# START HERE: implement Vector_to_string()
# START HERE: implement Vector_to_string()
# START HERE: implement Vector_to_string()

#print Dumper($retval_vector) . "\n";
print number_arrayref_to_string($retval_vector->{head}) . "\n";
#print Vector_to_string($retval_vector) . "\n";
