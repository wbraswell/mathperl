#!/usr/bin/perl

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Events.pod
# constant data
my @SDL_EVENTS = qw(
no_such_event
SDL_ACTIVEEVENT
SDL_KEYDOWN
SDL_KEYUP
SDL_MOUSEMOTION
SDL_MOUSEBUTTONDOWN
SDL_MOUSEBUTTONUP
SDL_JOYAXISMOTION
SDL_JOYBALLMOTION
SDL_JOYHATMOTION
SDL_JOYBUTTONDOWN
SDL_JOYBUTTONUP
SDL_QUIT
SDL_SYSWMEVENT
SDL_VIDEORESIZE
SDL_VIDEOEXPOSE
SDL_USEREVENT
SDL_NUMEVENTS
);

# https://metacpan.org/dist/SDL/view/lib/pods/SDL/Event.pod
use SDL;
use SDLx::App;
use SDL::Event;  # for the event object itself
use SDL::Events; # functions for event queue handling
 
SDL::init(SDL_INIT_VIDEO);
my $my_SDL_event = SDL::Event->new();

my $my_SDL_app = SDLx::App->new(
    title  => 'Application Title',
    width  => 640,
    height => 480,
    depth  => 32
);
 
while(1)
{
    SDL::Events::pump_events();
 
    if(SDL::Events::poll_event($my_SDL_event))
    {
        print 'have $my_SDL_event->type() = ', $my_SDL_event->type(), "\n";
        print 'have @SDL_EVENTS[$my_SDL_event->type()] = ', @SDL_EVENTS[$my_SDL_event->type()], "\n";

        if ($my_SDL_event->type == SDL_QUIT) {
            print 'SDL_QUIT event received, exiting', "\n";
            exit;
        }
    }
 
    # your screen drawing code will be here
}
