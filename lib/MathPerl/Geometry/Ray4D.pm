# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Ray4D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Ray);
use MathPerl::Geometry::Ray;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    origin    => my MathPerl::Geometry::Point4D  $TYPED_origin    = undef,
    direction => my MathPerl::Geometry::Vector4D $TYPED_direction = undef
};

1;    # end of class