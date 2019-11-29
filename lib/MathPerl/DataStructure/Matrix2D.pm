# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Matrix2D;
use strict;
use warnings;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Matrix);
use MathPerl::DataStructure::Matrix;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT_OK = qw(multiply_matrix2d);

# [[[ OO PROPERTIES ]]]
our hashref $properties = { data => my number_arrayref_arrayref $TYPED_data = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

sub init {
    { my void::method $RETURN_TYPE };
    ( my MathPerl::DataStructure::Matrix2D $self ) = @ARG;
    $self->{data} = [];
    $self->{data}->[0] = [];
}

# START HERE: create matmul tests, create stubs for Matrix3D.pm & Matrix4D.pm, work on AffineTransformation*.pm
# START HERE: create matmul tests, create stubs for Matrix3D.pm & Matrix4D.pm, work on AffineTransformation*.pm
# START HERE: create matmul tests, create stubs for Matrix3D.pm & Matrix4D.pm, work on AffineTransformation*.pm

sub multiply_matrix2d {
    { my MathPerl::DataStructure::Matrix2D $RETURN_TYPE };
    ( my MathPerl::DataStructure::Matrix2D $matrix_0, my MathPerl::DataStructure::Matrix2D $matrix_1 ) = @ARG;

#print {*STDERR} 'in MathPerl::DataStructure::Matrix2D::multiply_matrix2d()...', "\n";

    # NEED FIX: how to resize/grow/allocate matrix memory in C++ to allow direct indexing instead of push & pop in loop below?
    # NEED FIX: how to resize/grow/allocate matrix memory in C++ to allow direct indexing instead of push & pop in loop below?
    # NEED FIX: how to resize/grow/allocate matrix memory in C++ to allow direct indexing instead of push & pop in loop below?

    # create matrix to hold product result
    my MathPerl::DataStructure::Matrix2D $matrix_product = MathPerl::DataStructure::Matrix2D->new();

    # NEED FIX: remove manual call to init() as soon as it is auto-detected by RPerl
    $matrix_product->init();

    # run-time performance optimization, pre-fetch matrix data
    my number_arrayref_arrayref $matrix_0_data = $matrix_0->{data};
    my number_arrayref_arrayref $matrix_1_data = $matrix_1->{data};
    my number_arrayref_arrayref $matrix_product_data = $matrix_product->{data};

    # error check, inner dimensions must match
    my integer $matrix_0_num_columns = scalar $matrix_0_data->[0];
    my integer $matrix_1_num_rows = scalar $matrix_1_data;
    if ($matrix_0_num_columns != $matrix_1_num_rows) {
        croak 'Number of columns in matrix 0 does not match the number of rows in matrix 1, croaking';
    }

    # run-time performance optimization, pre-fetch matrix sizes (max indices)
    my integer $matrix_0_max_row_index = (scalar $matrix_0_data) - 1;
    my integer $matrix_0_max_column_index = $matrix_0_num_columns - 1;
    my integer $matrix_1_max_column_index = (scalar $matrix_1_data->[0]) - 1;

    for my integer $i ( 0 .. $matrix_0_max_row_index ) {
        # run-time performance optimization, pre-fetch matrix rows
        my number_arrayref $matrix_0_row_i = $matrix_0_data->[$i];
        my number_arrayref $matrix_product_row_i = $matrix_product_data->[$i];
        for my integer $j ( 0 .. $matrix_1_max_column_index ) {
            my number $sum = 0;
            for my integer $k ( 0 .. $matrix_0_max_column_index ) {
                $sum = $sum + ($matrix_0_row_i->[$k] * $matrix_1_data->[$k]->[$j]); 
            }
            $matrix_product_row_i->[$j] = $sum;
        }
    }

    return $matrix_product;
}

1;    # end of class