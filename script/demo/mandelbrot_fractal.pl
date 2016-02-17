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

#my integer $x_pixel_count = 160;
#my integer $x_pixel_count = 640;
my integer $x_pixel_count = 800;
#my integer $x_pixel_count = 1200;
if ( defined $ARGV[0] ) { $x_pixel_count = string_to_integer( $ARGV[0] ); }    # user input, command-line argument

#my integer $y_pixel_count = 120;
#my integer $y_pixel_count = 480;
my integer $y_pixel_count = 600;
#my integer $y_pixel_count = 800;
if ( defined $ARGV[1] ) { $y_pixel_count = string_to_integer( $ARGV[1] ); }    # user input, command-line argument

my integer $iterations_max = 100;
#my integer $iterations_max = 200;
#my integer $iterations_max = 1_000;
if ( defined $ARGV[2] ) { $iterations_max = string_to_integer( $ARGV[2] ); }    # user input, command-line argument

my boolean $enable_graphics = 1;
if ( defined $ARGV[3] ) { $enable_graphics = string_to_boolean( $ARGV[3] ); }   # user input, command-line argument

my number $time_start = time();

if ($enable_graphics) {
    my MathPerl::Fractal::MandelbrotRenderer2D $renderer = MathPerl::Fractal::MandelbrotRenderer2D->new();
    $renderer->init($x_pixel_count, $y_pixel_count, $iterations_max);
    $renderer->render2d_video();
}
else {
    my integer_arrayref_arrayref $mandelbrot_set = mandelbrot_escape_time( 
        $x_pixel_count, $y_pixel_count, $iterations_max, 
        MathPerl::Fractal::Mandelbrot::X_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::X_SCALE_MAX(),
        MathPerl::Fractal::Mandelbrot::Y_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::Y_SCALE_MAX());

    #print Dumper($mandelbrot_set) . "\n";
    print '[' . "\n";
    foreach my integer_arrayref $row ( @{$mandelbrot_set} ) {
        print '    [';
        foreach my integer $pixel ( @{$row} ) {
            print $pixel . ', ';
        }
        print '],' . "\n";
    }
    print ']' . "\n";
}

my number $time_total = time() - $time_start;
print 'time total:   ' . $time_total . ' seconds' . "\n";
