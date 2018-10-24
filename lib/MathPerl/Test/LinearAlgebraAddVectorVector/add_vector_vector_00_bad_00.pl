#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EMPLAADVV00' >>>
# <<< EXECUTE_ERROR: 'Dimensionality mismatch, input Vector 0 raw number_arrayref contains 5 elements and input Vector 1 raw number_arrayref contains 4 elements, dying' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::LinearAlgebra::AddVectorVector;

# [[[ OPERATIONS ]]]

print 'have MathPerl__DataStructure__Vector__MODE_ID() = ' . MathPerl__DataStructure__Vector__MODE_ID() . "\n\n";

my Vector $input_vector_0 = Vector->new();
my Vector $input_vector_1 = Vector->new();
my Vector $retval_vector;

# [[[ object AKA not raw ]]]

$input_vector_0->set_head([0, 2, 4, 6, 8]);
$input_vector_1->set_head([1, 3, 5, 7]);

$retval_vector = add_vector_vector( $input_vector_0, $input_vector_1 );
