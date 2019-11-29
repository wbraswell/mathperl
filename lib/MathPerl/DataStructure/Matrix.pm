# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Matrix;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::DataStructure::Matrix2D::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::DataStructure::Matrix2D qw(multiply_matrix2d);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
