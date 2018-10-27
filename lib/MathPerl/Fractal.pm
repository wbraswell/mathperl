# [[[ HEADER ]]]
use RPerl;
package MathPerl::Fractal;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT_OK = ( @MathPerl::Fractal::Julia::EXPORT_OK, @MathPerl::Fractal::Mandelbrot::EXPORT_OK );

# [[[ INCLUDES ]]]

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK
use MathPerl::Fractal::Julia qw(julia_escape_time);
use MathPerl::Fractal::Mandelbrot qw(mandelbrot_escape_time);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
