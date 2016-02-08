#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'Use of uninitialized value $x in numeric eq (==)' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
# ...

# [[[ INCLUDES ]]]
use MathPerl::Algebra;

# [[[ CONSTANTS ]]]
# ...

# [[[ SUBROUTINES ]]]
# ...

# [[[ OPERATIONS ]]]
my integer $x;
print solve($x - 2 == 0, $x);