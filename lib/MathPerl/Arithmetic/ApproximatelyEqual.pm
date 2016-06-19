# [[[ HEADER ]]]
use RPerl;
package MathPerl::Arithmetic::ApproximatelyEqual;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Operation);
use MathPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitParensWithBuiltins)  # USER DEFAULT 7: allow explicit parentheses for clearer order-of-operations precedence

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our boolean $approximately_equal = sub {
    (   my number $input_0,
        my number $input_1
    ) = @_;

    if ((abs ($input_0 - $input_1)) <= RPerl::EPSILON()) { return 1; }
    else { return 0; }
};

1;  # end of class
