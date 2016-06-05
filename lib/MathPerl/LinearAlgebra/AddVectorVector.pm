# [[[ HEADER ]]]
use RPerl;
package MathPerl::LinearAlgebra::AddVectorVector;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Operation);
use MathPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::Vector;
use MathPerl::DataStructure::Vector3D;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our MathPerl::DataStructure::Vector3D $add_vector3d_vector3d = sub {
    (   my MathPerl::DataStructure::Vector3D $input_0,
        my MathPerl::DataStructure::Vector3D $input_1
    ) = @_;

    my MathPerl::DataStructure::Vector3D $return_value = MathPerl::DataStructure::Vector3D->new();

    $return_value->{x} = $input_0->{x} + $input_1->{x};
    $return_value->{y} = $input_0->{y} + $input_1->{y};
    $return_value->{z} = $input_0->{z} + $input_1->{z};

    return $return_value;
};

our MathPerl::DataStructure::Vector $add_vector_vector = sub {
    (   my MathPerl::DataStructure::Vector $input_0,
        my MathPerl::DataStructure::Vector $input_1
    ) = @_;
    my MathPerl::DataStructure::Vector $return_value = MathPerl::DataStructure::Vector->new();
    $return_value->{data} = add_raw($input_0->{data}, $input_1->{data});
    return $return_value;
};

our number_arrayref $add_vector_vector_raw = sub {
    (   my number_arrayref $input_0,
        my number_arrayref $input_1
    ) = @_;

    my integer $input_0_dimensionality = scalar @{$input_0};
    my integer $input_1_dimensionality = scalar @{$input_1};

    if ($input_0_dimensionality != $input_0_dimensionality) {
        die 'ERROR EMPLAADVV00: Dimensionality mismatch, input vector 0 contains ' . $input_0_dimensionality .
            ' elements and input vector 1 contains ' . $input_1_dimensionality . ' elements, dying' . "\n";
    }

    my number_arrayref $return_value = [];

    for my integer $i (0 .. ($input_0_dimensionality - 1)) {
        $return_value->[$i] = $input_0->[$i] + $input_1->[$i];
    }

    return $return_value;
};

1;  # end of class
