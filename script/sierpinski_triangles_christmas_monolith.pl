#!/usr/bin/env perl

# Fractal Christmas Tree, Monolithic Single File
# Sierpinski triangles animated using SDL graphics

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
package main;
use strict;
use warnings;
our $VERSION = 0.007_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]
use English;
use Data::Dumper;

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Event.pod
use SDL;
use SDLx::App;   # used for window creation & control
use SDL::Event;  # used for creating Event object
use SDL::Events; # used for Event queue handling functions
use Time::HiRes qw( gettimeofday usleep );  # used for time-based animation control

# [[[ CONSTANTS ]]]

# [ DATA FOR SIZES & SHAPES & COLORS;
#   HARD-CODED 1024x768 RESOLUTION & 32-BIT COLOR DEPTH ]

# initial triangle's 3 corners as [x, y] Euclidean coordinates
my number::arrayref::arrayref $my_triangle_initial =
    [[ 512, 100],  # top point
     [ 212, 600],  # bottom left
     [ 812, 600]]; # bottom right

my integer::arrayref $my_color_red     = [255, 000, 000, 255];
my integer::arrayref $my_color_pink    = [255, 105, 220, 255];
my integer::arrayref $my_color_orange  = [255, 150, 000, 255];
my integer::arrayref $my_color_yellow  = [255, 255, 000, 255];
my integer::arrayref $my_color_green   = [000, 220, 000, 255];
my integer::arrayref $my_color_blue    = [000, 000, 255, 255];
my integer::arrayref $my_color_purple  = [175, 000, 255, 255];
my integer::arrayref $my_color_white   = [255, 255, 255, 255];
my integer::arrayref $my_color_brown   = [140, 100, 000, 255];

# colors as [r, g, b] triplets; number of colors is number of recursions
my integer::arrayref::arrayref $my_triangle_colors =
    [ $my_color_green,  # green needs to be the color of the smallest, and thus most numerous, triangles
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

# colors for animated Christmas tree lights
my integer::arrayref::arrayref $my_lights_colors = [$my_color_pink, $my_color_purple, $my_color_orange];

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Events.pod
my @SDL_EVENTS = qw( no_such_event SDL_ACTIVEEVENT SDL_KEYDOWN SDL_KEYUP SDL_MOUSEMOTION SDL_MOUSEBUTTONDOWN SDL_MOUSEBUTTONUP SDL_JOYAXISMOTION SDL_JOYBALLMOTION SDL_JOYHATMOTION SDL_JOYBUTTONDOWN SDL_JOYBUTTONUP SDL_QUIT SDL_SYSWMEVENT SDL_VIDEORESIZE SDL_VIDEOEXPOSE SDL_USEREVENT SDL_NUMEVENTS );  # constant data

# [[[ OPERATIONS ]]]

# [ PREPARE & MAKE INITIAL RECURSIVE CALL ]

# declare & initialize final array outside of the recursive subroutine for easy direct access by all recursive calls
my number::arrayref::arrayref::arrayref::arrayref $my_triangle_groups = [];

# initial triangle is in a triangle group by itself
$my_triangle_groups->[$my_recursions_remaining] = [$my_triangle_initial];

# initial call to recursive subroutine
sierpinski($my_triangle_initial, $my_recursions_remaining, $my_triangle_groups);

print 'have $my_triangle_groups = ', "\n", Dumper($my_triangle_groups);
print 'have $my_triangle_groups->[$my_recursions_remaining] = ', "\n", Dumper($my_triangle_groups->[$my_recursions_remaining]);

# [ INITIALIZE GRAPHICS ]

# SDL includes moved into [[[ INCLUDES ]]] section above

# initialize SDL video & application & event;
# we do not call $my_SDL_app->run() anywhere in this program, instead we use the while() run loop below
SDL::init(SDL_INIT_VIDEO);
my SDLx::App $my_SDL_app = SDLx::App->new(
    title  => 'Merry Christmas!!  Perl Advent 2022!!!',
    width  => 1024,                     # hard-coded 1024x768 resolution
    height => 768,
    depth  => 32,                       # hard-coded 32-bit color
    resizeable => 1                     # allow window resize; does not scale window contents
);
my $my_SDL_event = SDL::Event->new;

# [ RENDER STATIC GRAPHICS ]

# draw Christmas tree branches & snow tinsel & ornaments & lights;
# iterate through triangle groups in reverse order, due to reverse population during recursion
for (my $i = ((scalar @{$my_triangle_groups}) - 1); $i >= 0; $i--) {
    my number::arrayref::arrayref::arrayref $my_triangle_group = $my_triangle_groups->[$i];
    my integer::arrayref $my_color = $my_triangle_colors->[$i];

    for (my $j = 0; $j < (scalar @{$my_triangle_group}); $j++) {
        my number::arrayref::arrayref $my_triangle = $my_triangle_group->[$j];

        # https://metacpan.org/dist/SDL/view/lib/pods/SDLx/Surface.pod
        $my_SDL_app->draw_trigon_filled( $my_triangle, $my_color );

        # refresh window on every triangle for fun cascade drawing effect
        $my_SDL_app->update();
    }
}

# draw Christmas tree trunk & Star of Bethlehem
$my_SDL_app->draw_rect( $my_rectangle_trunk, $my_color_brown );
$my_SDL_app->draw_trigon_filled( $my_triangle_star_up, $my_color_yellow );
$my_SDL_app->draw_trigon_filled( $my_triangle_star_down, $my_color_yellow );
$my_SDL_app->update();  # refresh window

# [ RENDER DYNAMIC (ANIMATED) GRAPHICS ]

# set initial index for accesssing Christmas tree lights colors
my integer $my_lights_colors_index = 0;
 
# set initial time for changing Christmas tree lights colors
(my integer $seconds_start) = gettimeofday();
#print 'have $seconds_start = ', $seconds_start, "\n";
 
# the main run loop, used instead of calling $my_SDL_app->run();
# animate forever, until SDL_QUIT event is received in GUI window via <Alt-F4> keypress or window close mouse click,
# or in CLI window via <Ctrl-C> keypress
while(1)
{
    # pump the event loop, gathering events from input devices
    SDL::Events::pump_events();
 
    # poll for currently pending events
    if(SDL::Events::poll_event($my_SDL_event))
    {
        print 'have @SDL_EVENTS[', $my_SDL_event->type(), '] = ', @SDL_EVENTS[$my_SDL_event->type()], "\n";

        # we only care about the SDL_QUIT event telling us to exit
        if ($my_SDL_event->type == SDL_QUIT) {
            print 'SDL_QUIT event received, exiting', "\n";
            exit;
        }
    }
 
    # get current time, for comparison with start time of current Christmas tree lights color
    (my integer $seconds_current) = gettimeofday();
#    print 'have $seconds_current = ', $seconds_current, "\n";

    # twinkle Christmas tree lights every 1 second
    if (($seconds_current - $seconds_start) >= 1) {
        # reset start time to current time, for time cycle of next animation frame
        $seconds_start = $seconds_current;

        # iterate through lights colors
        my integer::arrayref $my_color = $my_lights_colors->[$my_lights_colors_index];
        print 'have $my_color = $my_lights_colors->[', $my_lights_colors_index, '] = ', Dumper($my_color);

        # wrap back to beginning of lights colors when end is reached
        $my_lights_colors_index++;
        if ($my_lights_colors_index > ((scalar @{$my_lights_colors}) - 1)) {
            $my_lights_colors_index = 0;
        }

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

        # refresh window once for every Christmas tree lights color change, for synchronized lights
        $my_SDL_app->update();
    }

    # briefly pause between each while() loop iteration, to avoid overloading CPU;
    # ( 1_000_000 microseconds per second ) / ( 10_000 microseconds per iteration) = 100 iterations per second;
    # need at least 100 while loop iterations per second, in order to process all of the otherwise-ignored SDL_MOUSEMOTION events
    # which are caused by simply moving the mouse over top of the window
    usleep(10_000);
}

# [[[ SUBROUTINES ]]]

# recursively generate triangles, grouped by recursion level
sub sierpinski {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
        my integer $recursions_remaining,
        my number::arrayref::arrayref::arrayref::arrayref $triangle_groups
    ) = @ARG;

    print 'in sierpinski(), received $triangle = ', Dumper($triangle), "\n";
    print 'in sierpinski(), received $recursions_remaining = ', $recursions_remaining, "\n";

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

1;  # end of package 'main'
