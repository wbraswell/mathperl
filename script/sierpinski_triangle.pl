#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

package void; 1;
package integer; 1; 
package integer::arrayref; 1;
package integer::arrayref::arrayref; 1;
package number::arrayref; 1;
package number::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref; 1;
package number::arrayref::arrayref::arrayref::arrayref; 1;

package main;
use English;
use Data::Dumper;

# [ DATA FOR SIZES & SHAPES & COLORS ]

# initial triangle's 3 corners as [x, y] Euclidean coordinates
my number::arrayref::arrayref $my_triangle_initial = 
    [[ 512, 100],  # top point
     [ 212, 600],  # bottom left
     [ 812, 600]]; # bottom right

my integer::arrayref $my_color_red         = [255, 000, 000, 255];
my integer::arrayref $my_color_pink        = [255, 105, 220, 255];
my integer::arrayref $my_color_orange      = [255, 150, 000, 255];
my integer::arrayref $my_color_yellow      = [255, 255, 000, 255];
my integer::arrayref $my_color_green       = [000, 255, 000, 255];
my integer::arrayref $my_color_green_dark  = [000, 220, 000, 255];
my integer::arrayref $my_color_blue        = [000, 000, 255, 255];
my integer::arrayref $my_color_purple      = [175, 000, 255, 255];
my integer::arrayref $my_color_white       = [255, 255, 255, 255];
my integer::arrayref $my_color_brown       = [140, 100, 000, 255];

# colors as [r, g, b] triplets; number of colors is number of recursions
my integer::arrayref::arrayref $my_triangle_colors = 
    [ $my_color_green_dark,  # green needs to be the color of the smallest, and thus most numerous, triangles
      $my_color_pink,
      $my_color_blue,
      $my_color_red,
      $my_color_white ];
my integer $my_recursions_remaining = scalar(@{$my_triangle_colors});

# rectangle in format [ x, y, width, height ]
my number::arrayref::arrayref $my_rectangle_trunk = 
    [462, 601, 100, 100];

my number::arrayref::arrayref $my_triangle_star_up =
    [[ 512, 050],  # top point
     [ 462, 130],  # bottom left
     [ 562, 130]]; # bottom right
my number::arrayref::arrayref $my_triangle_star_down =
    [[ 512, 155],  # bottom point
     [ 462,  70],  # top left
     [ 562,  70]]; # top right

# [ PREPARE & MAKE INITIAL RECURSIVE CALL ]

# declare & initialize final array outside of the recursive subroutine for easy direct access by all recursive calls
my number::arrayref::arrayref::arrayref::arrayref $my_triangle_groups = [];

# initial triangle is in a triangle group by itself
$my_triangle_groups->[$my_recursions_remaining] = [$my_triangle_initial];

# initial call to recursive subroutine
sierpinski($my_triangle_initial, $my_recursions_remaining, $my_triangle_groups);

print 'have $my_triangle_groups = ', "\n", Dumper($my_triangle_groups);
print 'have $my_triangle_groups->[$my_recursions_remaining] = ', "\n", Dumper($my_triangle_groups->[$my_recursions_remaining]);

# [ RENDER 2D GRAPHICs ]

use SDL;
use SDL::Video;
use SDLx::App;

SDL::init(SDL_INIT_VIDEO);
my SDLx::App $my_SDL_app = SDLx::App->new(
    title  => 'Perl Advent 2022!! Merry Christmas!!!',
    width  => 1024,
    height => 768,
    depth  => 32,                       # 32-bit color
    delay  => 25,                       # don't let SDL overload the CPU
    resizeable => 1                     # dual modes require window resize; NEED DELETE???
);

# START HERE: how to draw initial triangle persistently?  how to kill gracefully?
# START HERE: how to draw initial triangle persistently?  how to kill gracefully?
# START HERE: how to draw initial triangle persistently?  how to kill gracefully?

# draw initial triangle
#$my_SDL_app->draw_trigon_filled( $my_triangle_initial, $my_triangle_colors->[0] );
#$my_SDL_app->update();
#sleep(5);

# iterate through triangle groups in reverse order, due to reverse population during recursion
for (my $i = ((scalar @{$my_triangle_groups}) - 1); $i >= 0; $i--) {
    my number::arrayref::arrayref::arrayref $my_triangle_group = $my_triangle_groups->[$i];
    my integer::arrayref $my_color = $my_triangle_colors->[$i];

    for (my $j = 0; $j < (scalar @{$my_triangle_group}); $j++) {
        my number::arrayref::arrayref $my_triangle = $my_triangle_group->[$j];

        # https://metacpan.org/dist/SDL/view/lib/pods/SDLx/Surface.pod
        $my_SDL_app->draw_trigon_filled( $my_triangle, $my_color );
        $my_SDL_app->update();
    }
}

# draw Christmas tree trunk & Star of Bethlehem
$my_SDL_app->draw_rect( $my_rectangle_trunk, $my_color_brown );
$my_SDL_app->draw_trigon_filled( $my_triangle_star_up, $my_color_yellow );
$my_SDL_app->draw_trigon_filled( $my_triangle_star_down, $my_color_yellow );
$my_SDL_app->update();

# [ ANIMATIONS ]
while (1) {
    # twinkle Christmas tree lights; iterate through extra colors 
    foreach my integer::arrayref $my_color ($my_color_pink, $my_color_purple, $my_color_orange) {
        # only update second-smallest triangles, not the green of the Christmas tree itself
        my number::arrayref::arrayref::arrayref $my_triangle_group = $my_triangle_groups->[1];
        for (my $j = 0; $j < (scalar @{$my_triangle_group}); $j++) {
            my number::arrayref::arrayref $my_triangle = $my_triangle_group->[$j];
            $my_SDL_app->draw_trigon_filled( $my_triangle, $my_color );
        }

        # redraw green of Christmas tree
        $my_triangle_group = $my_triangle_groups->[0];
        for (my $j = 0; $j < (scalar @{$my_triangle_group}); $j++) {
            my number::arrayref::arrayref $my_triangle = $my_triangle_group->[$j];
            $my_SDL_app->draw_trigon_filled( $my_triangle, $my_triangle_colors->[0] );
        }

        # redraw Star of Bethlehem
        $my_SDL_app->draw_trigon_filled( $my_triangle_star_up, $my_color_yellow );
        $my_SDL_app->draw_trigon_filled( $my_triangle_star_down, $my_color_yellow );

        $my_SDL_app->update();
        sleep(1);
    }
}



# [[[ SUBROUTINES ]]]

# recursively generate triangles grouped by recursion level
sub sierpinski {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my integer $recursions_remaining,
        my number::arrayref::arrayref::arrayref::arrayref $triangle_groups
    ) = @ARG;

    print 'in sierpinski(), received $triangle = ', Dumper($triangle), "\n";
#    print 'in sierpinski(), received $recursions_remaining = ', $recursions_remaining, "\n";

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

1;                                                                                                              # end of class
