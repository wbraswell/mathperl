# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT    = ( @MathPerl::DataStructure::Vector::EXPORT );
our @EXPORT_OK = ( @MathPerl::DataStructure::ColorHSV::EXPORT_OK, @MathPerl::DataStructure::ColorRGB::EXPORT_OK);

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::DataStructure::ColorHSV qw(hsv_to_rgb);
use MathPerl::DataStructure::ColorRGB qw(rgb_to_hsv);
use MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
