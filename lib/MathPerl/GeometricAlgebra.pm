# [[[ HEADER ]]]
use RPerl;
package MathPerl::GeometricAlgebra;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::GeometricAlgebra::Products::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK

use MathPerl::GeometricAlgebra::Products qw(
    inner_product__vector_vector_euclidean
    inner_product__vector_bivector_euclidean
    inner_product__bivector_vector_euclidean
    inner_product__bivector_bivector_euclidean
    outer_product__vector_vector_euclidean
    outer_product__vector_bivector_euclidean
    outer_product__bivector_vector_euclidean
    outer_product__bivector_bivector_euclidean
    inner_product__vector_vector_minkowski
    inner_product__vector_bivector_minkowski
    inner_product__bivector_vector_minkowski
    inner_product__bivector_bivector_minkowski
    middle_product__bivector_bivector_minkowski
    outer_product__vector_vector_minkowski
    outer_product__vector_bivector_minkowski
    outer_product__bivector_vector_minkowski
    outer_product__bivector_bivector_minkowski
);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
