# [[[ HEADER ]]]
use RPerl;
package MathPerl::VectorAlgebra;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::VectorAlgebra::CrossProduct::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::VectorAlgebra::CrossProduct qw(cross_product_vector3d cross_product_vector);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
