# [[[ HEADER ]]]
use RPerl;

package MathPerl::Fractal::Mandelbrot;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Fractal);
use MathPerl::Fractal;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant X_SCALE_MIN => my number $TYPED_X_SCALE_MIN = -2.5;
use constant X_SCALE_MAX => my number $TYPED_X_SCALE_MAX = 1.0;
use constant Y_SCALE_MIN => my number $TYPED_Y_SCALE_MIN = -1.0;
use constant Y_SCALE_MAX => my number $TYPED_Y_SCALE_MAX = 1.0;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our integer_arrayref_arrayref $mandelbrot_escape_time = sub {
    ( my integer $x_pixel_count, my integer $y_pixel_count, my integer $iterations_max, my number $x_min, my number $x_max, my number $y_min, my number $y_max )
        = @_;
    print 'GENERATE MANDELBROT' . "\n";

    my integer_arrayref_arrayref $mandelbrot_set = integer_arrayref_arrayref::new( $y_pixel_count, $x_pixel_count );    # row-major form (RMF)
    my number $x_scaling_factor     = ( $x_max - $x_min ) / $x_pixel_count;
    my number $y_scaling_factor     = ( $y_max - $y_min ) / $y_pixel_count;
    my number $color_scaling_factor = 255 / $iterations_max;

    for my integer $y_pixel ( 0 .. ( $y_pixel_count - 1 ) ) {  # row-major form (RMF)
        for my integer $x_pixel ( 0 .. ( $x_pixel_count - 1 ) ) {
            my number $x_scaled = $x_min + ( $x_pixel * $x_scaling_factor );
            my number $y_scaled = $y_min + ( $y_pixel * $y_scaling_factor );
            my number $x        = 0.0;
            my number $y        = 0.0;
            my integer $i       = 0;
            while ( ( ( ( $x * $x ) + ( $y * $y ) ) < ( 2 * 2 ) ) and ( $i < $iterations_max ) ) {
                my number $x_tmp = ( $x * $x ) - ( $y * $y ) + $x_scaled;
                $y = ( 2 * $x * $y ) + $y_scaled;
                $x = $x_tmp;
                $i++;
            }
#            $mandelbrot_set->[$y_pixel]->[$x_pixel] = $i;  # do not scale to become color, leave as iteration count
            $mandelbrot_set->[$y_pixel]->[$x_pixel] = $i * $color_scaling_factor;  # scale to become color, black background
#            $mandelbrot_set->[$y_pixel]->[$x_pixel] = 255 - ( $i * $color_scaling_factor );    # scale to become color, invert for white background
        }
    }
    return $mandelbrot_set;
};

1;                                                                                             # end of class
