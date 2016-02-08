#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'true' >>>

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
my integer $x = 2;
if   ( solve( $x - 2 == 0, $x ) ) { print 'true' . "\n"; }
else                              { print 'false' . "\n"; }
