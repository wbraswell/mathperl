# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Ray3D;
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
    origin    => my MathPerl::Geometry::Point3D  $TYPED_origin    = undef,
    direction => my MathPerl::Geometry::Vector3D $TYPED_direction = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

our MathPerl::Geometry::Point3D $position_at_time = sub {
    ( my MathPerl::Geometry::Ray3D $self, my number $time ) = @_;
    my MathPerl::Geometry::Point3D $position = MathPerl::Geometry::Point3D->new();

    $position->{x} = $self->{origin}->{x} + ($self->{direction}->{x} * $time);
    $position->{y} = $self->{origin}->{y} + ($self->{direction}->{y} * $time);
    $position->{z} = $self->{origin}->{z} + ($self->{direction}->{z} * $time);

    return $position;
}

1;    # end of class