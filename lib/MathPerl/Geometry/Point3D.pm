# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Point3D;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Point);
use MathPerl::Geometry::Point;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    x => my number $TYPED_x = undef,
    y => my number $TYPED_y = undef,
    z => my number $TYPED_z = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

# DEV NOTE, CORRELATION #mp001: duplicate to_matrix_4x1() method, could be abstracted into MathPerl::Triplet class but that would require multiple inheritance
sub to_matrix_4x1 {
{
    { my MathPerl::Matrix::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Point3D $self, my number $final_element ) = @ARG;
    my MathPerl::Matrix $matrix = MathPerl::Matrix->new();

    $matrix->{data}->[0]->[0] = $self->{x};
    $matrix->{data}->[1]->[0] = $self->{y};
    $matrix->{data}->[2]->[0] = $self->{z};
    $matrix->{data}->[3]->[0] = $final_element;

    return $matrix;
}

1;    # end of class