#!/usr/bin/env perl

# Fractal, Program Source Code, Perl Implementation #X
# Calculate & Display Fractal Sets
# The Open Benchmarks Group
# http://openbenchmarks.org

# Contributed In Perl By Will Braswell

# $ ./script/demo/fractal.pl FOO_X FOO_Y
# FOO OUTPUT
# time total:   BAR seconds
# $ rperl lib/MathPerl/Fractal/Mandelbrot.pm lib/MathPerl/Fractal/Julia.pm
# $ ./script/demo/fractal.pl FOO_X FOO_Y
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
use MathPerl::Fractal::Julia;
use MathPerl::Fractal::Renderer2D;
use Time::HiRes qw(time);

# [[[ OPERATIONS ]]]

#my string $set_name = 'mandelbrot';
my string $set_name = 'julia';
if ( defined $ARGV[0] ) { $set_name = lc $ARGV[0]; }    # user input, command-line argument

my integer $x_pixel_count = 160;
#my integer $x_pixel_count = 640;
#my integer $x_pixel_count = 800;
#my integer $x_pixel_count = 1200;
if ( defined $ARGV[1] ) { $x_pixel_count = string_to_integer( $ARGV[0] ); }    # user input, command-line argument

my integer $y_pixel_count = 120;
#my integer $y_pixel_count = 480;
#my integer $y_pixel_count = 600;
#my integer $y_pixel_count = 800;
if ( defined $ARGV[2] ) { $y_pixel_count = string_to_integer( $ARGV[1] ); }    # user input, command-line argument

my integer $iterations_max = 150;
#my integer $iterations_max = 200;
if ( defined $ARGV[3] ) { $iterations_max = string_to_integer( $ARGV[2] ); }    # user input, command-line argument

my boolean $enable_graphics = 1;
if ( defined $ARGV[4] ) { $enable_graphics = string_to_boolean( $ARGV[3] ); }   # user input, command-line argument

my number $time_start = time();

if ($enable_graphics) {
    my MathPerl::Fractal::Renderer2D $renderer = MathPerl::Fractal::Renderer2D->new();
    $renderer->init($set_name, $x_pixel_count, $y_pixel_count, $iterations_max);
    $renderer->render2d_video();
}
else {
    # NEED UPGRADE: default to Mandelbrot only for non-graphics mode
    my integer_arrayref_arrayref $mandelbrot_set = mandelbrot_escape_time( 
        $x_pixel_count, $y_pixel_count, $iterations_max, 
        MathPerl::Fractal::Mandelbrot::X_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::X_SCALE_MAX(),
        MathPerl::Fractal::Mandelbrot::Y_SCALE_MIN(), MathPerl::Fractal::Mandelbrot::Y_SCALE_MAX(), 0);

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
