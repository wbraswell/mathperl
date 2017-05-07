# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Vector4D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Vector);
use MathPerl::Geometry::Vector;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    t => my number $TYPED_t = undef,
    x => my number $TYPED_x = undef,
    y => my number $TYPED_y = undef,
    z => my number $TYPED_z = undef
};

1;    # end of class