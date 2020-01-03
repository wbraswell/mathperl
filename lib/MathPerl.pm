# [[[ HEADER ]]]
package MathPerl;
use strict;
use warnings;
use RPerl::AfterSubclass;

# DEV NOTE, CORRELATION #rp016: CPAN's underscore-is-beta (NOT RPerl's underscore-is-comma) numbering scheme utilized here, to preserve trailing zeros
our $VERSION = '0.103000';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]

# DEV NOTE: outside of RPerl itself, the only subroutines which should be in @EXPORT are data conversion routines for RPerl data types and data structures, 
# and which have unique names, such as full-length-name stringify routines;
# the only subroutines which should be in @EXPORT_OK are those meant for public use and which have unique names;
# all other subroutines should be invoked with their entire package name prefix

use RPerl::Exporter 'import';
our @EXPORT = (
#                @MathPerl::Arithmetic::ApproximatelyEqual::EXPORT,  # unused
                @MathPerl::DataStructure::Vector::EXPORT,
#                @MathPerl::Fractal::Julia::EXPORT,  # unused
#                @MathPerl::Fractal::Mandelbrot::EXPORT,  # unused
#                @MathPerl::GeometricAlgebra::Products::EXPORT,  # unused
#                @MathPerl::Geometry::PiDigits::EXPORT,  # unused
#                @MathPerl::LinearAlgebra::AddVectorVector::EXPORT,  # unused
#                @MathPerl::VectorAlgebra::CrossProduct::EXPORT,  # unused
#                @MathPerl::DataStructure::Matrix2D::EXPORT,  # unused
                );
our @EXPORT_OK = (
                @MathPerl::Arithmetic::ApproximatelyEqual::EXPORT_OK,
#                @MathPerl::DataStructure::Vector::EXPORT_OK,  # unused
                @MathPerl::Fractal::Julia::EXPORT_OK,
                @MathPerl::Fractal::Mandelbrot::EXPORT_OK,
                @MathPerl::GeometricAlgebra::Products::EXPORT_OK,
                @MathPerl::Geometry::PiDigits::EXPORT_OK,
                @MathPerl::LinearAlgebra::AddVectorVector::EXPORT_OK, 
                @MathPerl::VectorAlgebra::CrossProduct::EXPORT_OK,
                @MathPerl::DataStructure::Matrix2D::EXPORT_OK,
                );

# [[[ INCLUDES ]]]
use MathPerl::Config;

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK

use MathPerl::Arithmetic::ApproximatelyEqual qw(approximately_equal);
use MathPerl::DataStructure::Vector;
use MathPerl::Fractal::Julia qw(julia_escape_time);
use MathPerl::Fractal::Mandelbrot qw(mandelbrot_escape_time);
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
use MathPerl::Geometry::PiDigits qw(extract_digit eliminate_digit next_term display_pi_digits);
use MathPerl::LinearAlgebra::AddVectorVector qw(add_vector_vector);
use MathPerl::VectorAlgebra::CrossProduct qw(cross_product_vector3d cross_product_vector);
use MathPerl::DataStructure::Matrix2D qw(multiply_matrix2d);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
