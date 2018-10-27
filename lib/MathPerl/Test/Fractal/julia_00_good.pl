#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '[0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, ],' >>>
# <<< EXECUTE_SUCCESS: '[0, 0, 0, 1, 1, 1, 2, 2, 5, 3, 2, 2, 1, 1, 1, 1, ],' >>>
# <<< EXECUTE_SUCCESS: '[0, 0, 1, 1, 1, 2, 2, 4, 255, 255, 4, 3, 2, 2, 1, 1, ],' >>>
# <<< EXECUTE_SUCCESS: '[0, 1, 1, 1, 2, 3, 4, 83, 255, 50, 33, 7, 5, 89, 3, 2, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 1, 2, 3, 5, 5, 5, 8, 234, 44, 255, 218, 10, 135, 138, 4, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 2, 3, 255, 106, 175, 17, 108, 24, 226, 164, 191, 51, 47, 255, 255, ],' >>>
# <<< EXECUTE_SUCCESS: '[2, 4, 255, 9, 208, 115, 105, 255, 81, 255, 105, 115, 208, 9, 255, 4, ],' >>>
# <<< EXECUTE_SUCCESS: '[3, 255, 255, 47, 51, 191, 164, 226, 24, 108, 17, 175, 106, 255, 3, 2, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 4, 138, 135, 10, 218, 255, 44, 234, 8, 5, 5, 5, 3, 2, 1, ],' >>>
# <<< EXECUTE_SUCCESS: '[1, 2, 3, 89, 5, 7, 33, 50, 255, 83, 4, 3, 2, 1, 1, 1, ],' >>>
# <<< EXECUTE_SUCCESS: '[0, 1, 1, 2, 2, 3, 4, 255, 255, 4, 2, 2, 1, 1, 1, 0, ],' >>>
# <<< EXECUTE_SUCCESS: '[0, 1, 1, 1, 1, 2, 2, 3, 5, 2, 2, 1, 1, 1, 0, 0, ],' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::Fractal::Julia;

# [[[ OPERATIONS ]]]

my integer $x_pixel_count = 16;
my integer $y_pixel_count = 12;
my integer $iterations_max = 300;

my integer_arrayref_arrayref $julia_set;
$julia_set = MathPerl::Fractal::Julia::julia_escape_time(
    -0.7, 0.270_15,
    $x_pixel_count, $y_pixel_count, $iterations_max,
    MathPerl::Fractal::Julia::X_SCALE_MIN(),
    MathPerl::Fractal::Julia::X_SCALE_MAX(),
    MathPerl::Fractal::Julia::Y_SCALE_MIN(),
    MathPerl::Fractal::Julia::Y_SCALE_MAX(), 0
);

print '[' . "\n";
foreach my integer_arrayref $row ( @{$julia_set} ) {
    print '    [';
    foreach my integer $pixel ( @{$row} ) {
        print $pixel . ', ';
    }
    print '],' . "\n";
}
print ']' . "\n";
