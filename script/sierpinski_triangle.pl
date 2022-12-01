#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

package void; 1;
package integer; 1; 
package number::arrayref; 1;
package number::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref::arrayref; 1;

package main;
use English;
use Data::Dumper;

# initial triangle's 3 corners as [x, y] Euclidean coordinates
my number::arrayref::arrayref $my_triangle = 
    [[ 0.0,  0.0],
     [10.0,  0.0],
     [ 5.0, 10.0]];

# colors as [r, g, b] triplets; number of colors is number of recursions
my number::arrayref::arrayref $my_colors =
    [[0.0, 1.0, 0.0],   # green
     [0.2, 0.2, 0.2],   # brown
     [1.0, 0.0, 0.0],   # red
     [1.0, 1.0, 1.0]];  # white
my integer $my_recursions_remaining = scalar(@{$my_colors});

# declare & initialize final array outside of the recursive subroutine for easy direct access by all recursive calls
my number::arrayref::arrayref::arrayref::arrayref $my_triangle_groups = [];

# initial triangle is in a triangle group by itself
$my_triangle_groups->[$my_recursions_remaining] = [$my_triangle];

# initial call to recursive subroutine
sierpinski($my_triangle, $my_recursions_remaining, $my_triangle_groups);

print 'have $my_triangle_groups = ', "\n", Dumper($my_triangle_groups);
print 'have $my_triangle_groups->[$my_recursions_remaining] = ', "\n", Dumper($my_triangle_groups->[$my_recursions_remaining]);

#foreach ... {
    # DRAW TRIANGLES
#}


# recursively generate triangles grouped by recursion level
sub sierpinski {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my integer $recursions_remaining,
        my number::arrayref::arrayref::arrayref::arrayref $triangle_groups
    ) = @ARG;

    print 'in sierpinski(), received $triangle = ', Dumper($triangle), "\n";
    print 'in sierpinski(), received $recursions_remaining = ', $recursions_remaining, "\n";


# START HERE: add debugging statements at recurse & return; get correct triangle data; draw triangles
# START HERE: add debugging statements at recurse & return; get correct triangle data; draw triangles
# START HERE: add debugging statements at recurse & return; get correct triangle data; draw triangles


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
}


sub draw_triangle {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my number::arrayref::arrayref $color,
    ) = @ARG;

    print 'in draw_triangle()' . "\n";
}

1;                                                                                                              # end of class
