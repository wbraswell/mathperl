#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

package void;
1;

package integer;
1;

package number::arrayref;
1;

package number::arrayref::arrayref;
1;

package number::arrayref::arrayref::arrayref;
1;

package number::arrayref::arrayref::arrayref::arrayref;
1;

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

# generate triangles grouped by recursion level
my number::arrayref::arrayref::arrayref::arrayref $sierpinski_triangles = sierpinski($my_triangle, scalar(@{$my_colors}));

#foreach ... {
    # DRAW TRIANGLES
#}


sub sierpinski {
    { my number::arrayref::arrayref::arrayref $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my integer $recursions_remaining
    ) = @ARG;

    print 'in sierpinski(), received $triangle = ', Dumper($triangle), "\n";
    print 'in sierpinski(), received $recursions_remaining = ', $recursions_remaining, "\n";

# START HERE: need correct initialization for $return_value; add debugging statements at recurse & return; get correct triangle data
# START HERE: need correct initialization for $return_value; add debugging statements at recurse & return; get correct triangle data
# START HERE: need correct initialization for $return_value; add debugging statements at recurse & return; get correct triangle data

    my number::arrayref::arrayref $return_value = [ [ ] ];

    if ($recursions_remaining > 0) {
        $recursions_remaining--;

        # shortcut variables, easier to read in midpoint calculations below
        my number::arrayref $point_a = $triangle->[0];
        my number::arrayref $point_b = $triangle->[1];
        my number::arrayref $point_c = $triangle->[2];

        # midpoint between two coordinates [x1, y1] and [x2, y2] is [(x1+x2)/2, (y1+y2)/2]
        my number::arrayref::arrayref $subtriangle_a =
            [   $point_a,
             [(($point_a->[0] + $point_b->[0]) / 2), 
              (($point_a->[1] + $point_b->[1]) / 2)],
             [(($point_a->[0] + $point_c->[0]) / 2), 
              (($point_a->[1] + $point_c->[1]) / 2)]];
        my number::arrayref::arrayref $subtriangle_b =
            [[(($point_a->[0] + $point_b->[0]) / 2), 
              (($point_a->[1] + $point_b->[1]) / 2)],
                $point_b,
             [(($point_b->[0] + $point_c->[0]) / 2), 
              (($point_b->[1] + $point_c->[1]) / 2)]];
        my number::arrayref::arrayref $subtriangle_c =
            [[(($point_a->[0] + $point_c->[0]) / 2), 
              (($point_a->[1] + $point_c->[1]) / 2)],
             [(($point_b->[0] + $point_c->[0]) / 2), 
              (($point_b->[1] + $point_c->[1]) / 2)],
                $point_c                        ];

        # recurse
        push @{$return_value}, 
        [
            sierpinski( $subtriangle_a, $recursions_remaining ),
            sierpinski( $subtriangle_b, $recursions_remaining ),
            sierpinski( $subtriangle_c, $recursions_remaining ),
        ];
    }

    return $return_value;
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
