# [[[ HEADER ]]]
use RPerl;
package MathPerl::LinearAlgebra::AddVectorVector;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Operation);
use MathPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::Vector;
use MathPerl::Arithmetic::ApproximatelyEqual;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our MathPerl::DataStructure::Vector $add_vector_vector = sub {
    (   my MathPerl::DataStructure::Vector $input_0,
        my MathPerl::DataStructure::Vector $input_1
    ) = @_;
    my MathPerl::DataStructure::Vector $return_value = MathPerl::DataStructure::Vector->new();
    $return_value->{head} = add_vector_vector_raw($input_0->{head}, $input_1->{head});
    return $return_value;
};

our number_arrayref $add_vector_vector_raw = sub {
    (   my number_arrayref $input_0,
        my number_arrayref $input_1
    ) = @_;

    my integer $input_0_dimensionality = scalar @{$input_0};
    my integer $input_1_dimensionality = scalar @{$input_1};

#    print 'in AddVectorVector.pm MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw(), have input_0_dimensionality = ', $input_0_dimensionality, "\n";
#    print 'in AddVectorVector.pm MathPerl__LinearAlgebra__AddVectorVector__add_vector_vector_raw(), have input_1_dimensionality = ', $input_1_dimensionality, "\n";

    if ($input_0_dimensionality != $input_1_dimensionality) {
        die 'ERROR EMPLAADVV00: Dimensionality mismatch, input Vector 0 raw number_arrayref contains ', $input_0_dimensionality,
            ' elements and input Vector 1 raw number_arrayref contains ', $input_1_dimensionality, ' elements, dying', "\n";
    }

# START HERE: do not generate C++ empty array in variable declaration below
# START HERE: do not generate C++ empty array in variable declaration below
# START HERE: do not generate C++ empty array in variable declaration below

    my number_arrayref $return_value = [];
    $return_value->[$input_0_dimensionality - 1] = undef;  # arrayref resize

    for my integer $i (0 .. ($input_0_dimensionality - 1)) {
        $return_value->[$i] = $input_0->[$i] + $input_1->[$i];
    }

    return $return_value;
};

1;  # end of class
