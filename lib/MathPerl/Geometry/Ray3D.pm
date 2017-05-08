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

# START HERE: implement MathPerl::Matrix & MathPerl::Geometric::Affine*

our MathPerl::Geometry::Ray3D::method $transform = sub {
{
    ( my MathPerl::Geometry::Ray3D $self, my MathPerl::Geometry::AffineTransformation3D $transform ) = @_;
    my MathPerl::Geometry::Ray3D $transformed_ray = MathPerl::Geometry::Ray3D->new();

    # NEED OPTIMIZE: is there any way to hard-code the individual computations to avoid calling MathPerl::Matrix::multiply() or to_matrix_4x1() below?

    # transform ray origin
    my MathPerl::Matrix $transformed_origin_matrix = MathPerl::Matrix::multiply($transform->{data}, $self->{origin}->to_matrix_4x1(1));
    $transformed_ray->{origin}->{x} = $transformed_origin_matrix->{data}->[0]->[0];
    $transformed_ray->{origin}->{y} = $transformed_origin_matrix->{data}->[1]->[0];
    $transformed_ray->{origin}->{z} = $transformed_origin_matrix->{data}->[2]->[0];

    # transform ray direction
    my MathPerl::Matrix $transformed_direction_matrix = MathPerl::Matrix::multiply($transform->{data}, $self->{direction}->to_matrix_4x1(0));
    $transformed_ray->{direction}->{x} = $transformed_direction_matrix->{data}->[0]->[0];
    $transformed_ray->{direction}->{y} = $transformed_direction_matrix->{data}->[1]->[0];
    $transformed_ray->{direction}->{z} = $transformed_direction_matrix->{data}->[2]->[0];

    return $transformed_ray;
};


our MathPerl::Geometry::Point3D::method $position_at_time = sub {
    ( my MathPerl::Geometry::Ray3D $self, my number $time ) = @_;
    my MathPerl::Geometry::Point3D $position = MathPerl::Geometry::Point3D->new();

    $position->{x} = $self->{origin}->{x} + ($self->{direction}->{x} * $time);
    $position->{y} = $self->{origin}->{y} + ($self->{direction}->{y} * $time);
    $position->{z} = $self->{origin}->{z} + ($self->{direction}->{z} * $time);

    return $position;
}

1;    # end of class