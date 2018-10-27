# [[[ HEADER ]]]
use RPerl;
package MathPerl::LinearAlgebra;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::LinearAlgebra::AddVectorVector::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::LinearAlgebra::AddVectorVector qw(add_vector_vector);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
