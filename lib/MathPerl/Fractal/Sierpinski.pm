# [[[ PREPROCESSOR ]]]
# declare Perl-compatible data types & data structures 
package void; 1;
package integer; 1;
package integer::arrayref; 1;
package integer::arrayref::arrayref; 1;
package number::arrayref; 1;
package number::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref::arrayref; 1;

# [[[ HEADER ]]]
#use RPerl;  # replaced by PREPROCESSOR for simplicity
package MathPerl::Fractal::Sierpinski;
use strict;
use warnings;
use v5.14;  # required for /r return AKA non-destructive regex flag
our $VERSION = 0.008_000;

# [[[ CRITICS ]]]
# USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ OO INHERITANCE ]]]
#use parent qw(MathPerl::Fractal);  # disable unnecessary inheritance for simplicity
#use MathPerl::Fractal;

# [[[ INCLUDES ]]]
use English;
use Data::Dumper;
$Data::Dumper::Deepcopy = 1;  # display human-readable numeric data, not $VAR1->[0] references

# [[[ SUBROUTINES ]]]

# recursively generate triangles, grouped by recursion level
sub sierpinski {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my integer $recursions_remaining,
        my number::arrayref::arrayref::arrayref::arrayref $triangle_groups
    ) = @ARG;

    print 'in sierpinski(), received $recursions_remaining = ', $recursions_remaining, "\n";
    print 'in sierpinski(), received $triangle = ', (Dumper($triangle) =~ s/'//gr), "\n";

    if ($recursions_remaining > 0) {
        # shortcut variables, easier to read in midpoint calculations below
        my number::arrayref $point_a = $triangle->[0];
        my number::arrayref $point_b = $triangle->[1];
        my number::arrayref $point_c = $triangle->[2];

        # calculate midpoints between two coordinates [x1, y1] and [x2, y2] is [(x1+x2)/2, (y1+y2)/2]
        my number::arrayref $point_a_b =
            [(($point_a->[0] + $point_b->[0]) / 2),
             (($point_a->[1] + $point_b->[1]) / 2)];
        my number::arrayref $point_a_c =
            [(($point_a->[0] + $point_c->[0]) / 2),
             (($point_a->[1] + $point_c->[1]) / 2)];
        my number::arrayref $point_b_c =
            [(($point_b->[0] + $point_c->[0]) / 2),
             (($point_b->[1] + $point_c->[1]) / 2)];

        # construct 3 sub-triangles from orinal points and newly-calculated midpoints
        my number::arrayref::arrayref $subtriangle_a = [ $point_a,   $point_a_b, $point_a_c ];
        my number::arrayref::arrayref $subtriangle_b = [ $point_a_b, $point_b,   $point_b_c ];
        my number::arrayref::arrayref $subtriangle_c = [ $point_a_c, $point_b_c, $point_c   ];

        # $triangle_groups is zero-indexed like all other Perl arrays,
        # so we need to subtract one from $recursions_remaining before using as an index,
        # in order to avoid an undefined element at element 0;
        # also, we need to decrement $recursions_remaining before making recursive calls;
        # for both of these reasons, we can decrement now
        $recursions_remaining--;

        # store all triangles grouped by recursion level
        push @{$triangle_groups->[$recursions_remaining]}, $subtriangle_a;
        push @{$triangle_groups->[$recursions_remaining]}, $subtriangle_b;
        push @{$triangle_groups->[$recursions_remaining]}, $subtriangle_c;

        # recurse once for each sub-triangle
        sierpinski( $subtriangle_a, $recursions_remaining, $triangle_groups);
        sierpinski( $subtriangle_b, $recursions_remaining, $triangle_groups);
        sierpinski( $subtriangle_c, $recursions_remaining, $triangle_groups);
    }

    # return after maximum recursion level is reached (conditional block above not entered),
    # or all recursion calls have returned (conditional block above entered);
    # no return value, all generated data is stored directly in $triangle_groups
    return;
}

1;  # end of class
