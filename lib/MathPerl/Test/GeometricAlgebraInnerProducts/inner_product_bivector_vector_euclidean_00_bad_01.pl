#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EAVRV10, BOUND-CHECKING MISMATCH: Argument $input_bivector is not of length 4' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # useR DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::GeometricAlgebra::Products;

# [[[ OPERATIONS ]]]
my number_arrayref $retval_vector;
my number_arrayref $input_bivector;
my number_arrayref $input_vector;
$input_bivector = [-999999, 3.0, 4.0, 12.0, 0.0];
$input_vector = [-999999, 3.0, 4.0, -12.0];
$retval_vector = MathPerl::GeometricAlgebra::Products::inner_product__bivector_vector_euclidean( $input_bivector, $input_vector );
print Dumper($retval_vector) . "\n";
