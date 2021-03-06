#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '0' >>>

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

my number_arrayref $input_vector_1 = [ -999_999, 0.0, 0.0, 0.0 ];
my number_arrayref $input_vector_2 = [ -999_999, 3.0, 4.0, 12.0 ];
my number $retval_number = MathPerl::GeometricAlgebra::Products::inner_product__vector_vector_euclidean( $input_vector_1, $input_vector_2 );
print $retval_number . "\n";
