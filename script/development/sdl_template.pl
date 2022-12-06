#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# define Perl-compatible data types & data structures 
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

# [ DATA FOR SIZES & SHAPES & COLORS;
#   HARD-CODED 1024x768 RESOLUTION & 32-BIT COLOR DEPTH ]

# triangle's 3 corners as [x, y] Euclidean coordinates
my number::arrayref::arrayref $my_triangle =
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

# rectangle in format [ x, y, width, height ]
my number::arrayref::arrayref $my_rectangle =
    [462, 601, 100, 100];

my integer::arrayref::arrayref $my_colors = [$my_color_pink, $my_color_purple, $my_color_orange];

# [ INITIALIZE GRAPHICS ]

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Events.pod
my @SDL_EVENTS = qw( no_such_event SDL_ACTIVEEVENT SDL_KEYDOWN SDL_KEYUP SDL_MOUSEMOTION SDL_MOUSEBUTTONDOWN SDL_MOUSEBUTTONUP SDL_JOYAXISMOTION SDL_JOYBALLMOTION SDL_JOYHATMOTION SDL_JOYBUTTONDOWN SDL_JOYBUTTONUP SDL_QUIT SDL_SYSWMEVENT SDL_VIDEORESIZE SDL_VIDEOEXPOSE SDL_USEREVENT SDL_NUMEVENTS );  # constant data

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Event.pod
use SDL;
use SDLx::App;   # used for window creation & control
use SDL::Event;  # used for creating Event object
use SDL::Events; # used for Event queue handling functions
use Time::HiRes qw( gettimeofday usleep );  # used for time-based animation control

# initialize SDL video & application & event;
# we do not call $my_SDL_app->run() anywhere in this program, instead we use the while() run loop below
SDL::init(SDL_INIT_VIDEO);
my SDLx::App $my_SDL_app = SDLx::App->new(
    title  => 'FOO BAR WINDOW TITLE',
    width  => 1024,                     # hard-coded 1024x768 resolution
    height => 768,
    depth  => 32,                       # hard-coded 32-bit color
    resizeable => 1                     # allow window resize; does not scale window contents
);
my $my_SDL_event = SDL::Event->new;

# [ RENDER STATIC GRAPHICS ]

# https://metacpan.org/dist/SDL/view/lib/pods/SDLx/Surface.pod
$my_SDL_app->draw_trigon_filled( $my_triangle, $my_color_green );
$my_SDL_app->draw_rect( $my_rectangle, $my_color_brown );

# refresh window
$my_SDL_app->update();

# [ RENDER DYNAMIC (ANIMATED) GRAPHICS ]

# set initial index for accesssing animation colors
my integer $my_colors_index = 0;
 
# set initial time for animation frame
(my integer $seconds_start, my integer $microseconds_start) = gettimeofday();
#print 'have $seconds_start = ', $seconds_start, "\n";
#print 'have $microseconds_start = ', $microseconds_start, "\n";
 
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
 
    # get current time, for comparison with start time of current animation frame
    (my integer $seconds_current, my integer $microseconds_current) = gettimeofday();
#    print 'have $seconds_current = ', $seconds_current, "\n";
#    print 'have $microseconds_current = ', $microseconds_current, "\n";

    # animate new frame every 1 second; change to microseconds for multiple frames per second
    if (($seconds_current - $seconds_start) >= 1) {
        # reset start time to current time, for time cycle of next animation frame
        $seconds_start = $seconds_current;

        # iterate through colors
        my integer::arrayref $my_color = $my_colors->[$my_colors_index];
        print 'have $my_color = $my_colors->[', $my_colors_index, '] = ', Dumper($my_color);

        # wrap back to beginning of lights colors when end is reached
        $my_colors_index++;
        if ($my_colors_index > ((scalar @{$my_colors}) - 1)) {
            $my_colors_index = 0;
        }

        # redraw triangle with new color
        $my_SDL_app->draw_trigon_filled( $my_triangle, $my_color );

        # refresh window once for animation frame
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
sub foo_bar {
    { my void $RETURN_TYPE };
    (
        my number::arrayref::arrayref $triangle,
    ) = @ARG;

    print 'in sierpinski(), received $triangle = ', Dumper($triangle), "\n";

    # FOO BAR CODE

    return;
}

1;  # end of class
