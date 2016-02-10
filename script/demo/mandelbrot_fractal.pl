#!/usr/bin/env perl

# Mandelbrot Fractal, Program Source Code, Perl Implementation #X
# Calculate & Display Mandelbrot Fractal Set
# The Open Benchmarks Group
# http://openbenchmarks.org

# Contributed In Perl By Will Braswell

# $ ./script/demo/mandelbrot_fractal.pl FOO_X FOO_Y
# FOO OUTPUT
# time total:   BAR seconds
# $ rperl lib/MathPerl/Fractal/Mandelbrot.pm
# $ ./script/demo/mandelbrot_fractal.pl FOO_X FOO_Y
# FOO OUTPUT
# time total:   BAR seconds

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'FOO BAR' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::Fractal::Mandelbrot;
use MathPerl::Fractal::MandelbrotRenderer2D;
use Time::HiRes qw(time);

# [[[ OPERATIONS ]]]

my integer $x_pixel_count = 64;  # default
#my integer $x_pixel_count = 640;  # default
if (defined $ARGV[0]) { $x_pixel_count = string_to_integer($ARGV[0]); }  # user input, command-line argument

my integer $y_pixel_count = 48;  # default
#my integer $y_pixel_count = 480;  # default
if (defined $ARGV[1]) { $y_pixel_count = string_to_integer($ARGV[1]); }  # user input, command-line argument

my boolean $enable_graphics = 1;  # default 
if (defined $ARGV[2]) { $enable_graphics = string_to_boolean($ARGV[2]); }  # user input, command-line argument

my number $time_start = time();

my integer_arrayref_arrayref $mandelbrot_set = mandelbrot_escape_time($x_pixel_count, $y_pixel_count);

if ($enable_graphics) {
    my MathPerl::Fractal::MandelbrotRenderer2D $renderer = MathPerl::Fractal::MandelbrotRenderer2D->new();
    $renderer->render2d_frame($mandelbrot_set);
}

print Dumper($mandelbrot_set) . "\n";

my number $time_total = time() - $time_start;
print 'time total:   ' . $time_total . ' seconds' . "\n";
