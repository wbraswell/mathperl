# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::Geometry::PiDigits::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::Geometry::PiDigits qw(extract_digit eliminate_digit next_term display_pi_digits);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
