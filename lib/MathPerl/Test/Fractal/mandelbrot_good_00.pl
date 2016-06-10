#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 1, 2, 3, 3, 3, 3, 4, 5, 9, 4, 3, 2, 2, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 1, 3, 3, 3, 3, 4, 5, 8, 300, 5, 4, 3, 2, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 2, 3, 3, 3, 4, 5, 300, 14, 300, 16, 10, 3, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 3, 3, 3, 5, 5, 6, 52, 300, 300, 300, 17, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 3, 4, 5, 11, 9, 10, 300, 300, 300, 300, 300, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 4, 5, 8, 300, 300, 20, 300, 300, 300, 300, 300, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 9, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 4, 5, 8, 300, 300, 20, 300, 300, 300, 300, 300, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 3, 4, 5, 11, 9, 10, 300, 300, 300, 300, 300, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 3, 3, 3, 5, 5, 6, 52, 300, 300, 300, 17, 4, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 2, 3, 3, 3, 4, 5, 300, 14, 300, 16, 10, 3, 3, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 1, 1, 3, 3, 3, 3, 4, 5, 8, 300, 5, 4, 3, 2, ],' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::Fractal::Mandelbrot;

# [[[ OPERATIONS ]]]

my integer $x_pixel_count = 16;
my integer $y_pixel_count = 12;
my integer $iterations_max = 300;

my integer_arrayref_arrayref $set;
my number $x_scaling_factor = ( MathPerl::Fractal::Mandelbrot::X_SCALE_MAX() - MathPerl::Fractal::Mandelbrot::X_SCALE_MIN() ) / $x_pixel_count;
my number $y_scaling_factor = ( MathPerl::Fractal::Mandelbrot::Y_SCALE_MAX() - MathPerl::Fractal::Mandelbrot::Y_SCALE_MIN() ) / $y_pixel_count;
$set = mandelbrot_escape_time(
    $x_scaling_factor, $y_scaling_factor, $x_pixel_count, $y_pixel_count, $iterations_max,
    MathPerl::Fractal::Mandelbrot::X_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::X_SCALE_MAX(),
    MathPerl::Fractal::Mandelbrot::Y_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::Y_SCALE_MAX(), 0
);

print '[' . "\n";
foreach my integer_arrayref $row ( @{$set} ) {
    print '    [';
    foreach my integer $pixel ( @{$row} ) {
        print $pixel . ', ';
    }
    print '],' . "\n";
}
print ']' . "\n";
