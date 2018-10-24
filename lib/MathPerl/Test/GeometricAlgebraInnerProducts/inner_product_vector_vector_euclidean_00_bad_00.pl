#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EAVRV10, BOUND-CHECKING MISMATCH: Argument $input_vector_1 is not of length 4' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_020;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::GeometricAlgebra;

# [[[ OPERATIONS ]]]
my number_arrayref $input_vector_1 = [ -999_999, 3.0, 4.0 ];
my number_arrayref $input_vector_2 = [ -999_999, 3.0, 4.0, -12.0 ];
my number $retval_number
    = inner_product__vector_vector_euclidean( $input_vector_1,
    $input_vector_2 );
print $retval_number . "\n";
