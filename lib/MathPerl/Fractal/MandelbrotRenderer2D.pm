# [[[ HEADER ]]]
package MathPerl::Fractal::MandelbrotRenderer2D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
#use MathPerl::Fractal::Mandelbrot;
use Time::HiRes qw(time);
use SDL;
use SDL::Event;
use SDL::Video;
use SDLx::App;

#use SDLx::Sprite;
use SDLx::Text;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    mandelbrot_set => my integer_arrayref_arrayref $TYPED_mandelbrot_set = undef,
    iterations_max => my integer $TYPED_iterations_max = undef,

    #    delta_time => my number $TYPED_delta_time = undef,
    #    time_step_max => my integer $TYPED_time_step_max = undef,
    #    time_step_current => my integer $TYPED_time_step_current = undef,
    #    time_steps_per_frame => my integer $TYPED_time_steps_per_frame = undef,
    #    time_start => my number $TYPED_time_start = undef,
    window_title  => my string $TYPED_window_title   = undef,
    window_width  => my integer $TYPED_window_width  = undef,
    window_height => my integer $TYPED_window_height = undef,
    zoom          => my number $TYPED_zoom           = undef,
    app           => my SDLx::App $TYPED_app         = undef
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $init = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self, my integer $x_pixel_count, my integer $y_pixel_count ) = @_;

    #    $self->{delta_time} = $delta_time;
    #    $self->{time_step_max} = $time_step_max;
    #    $self->{time_step_current} = 0;
    #    $self->{time_steps_per_frame} = $time_steps_per_frame;
    #    $self->{time_start} = $time_start;

    # NEED FIX: remove hard-coded window size
    $self->{window_title}  = 'Mandelbrot Fractal Generator';
    $self->{window_width}  = $x_pixel_count;
    $self->{window_height} = $y_pixel_count;
    $self->{zoom}          = 1;

    SDL::init(SDL_INIT_VIDEO);

    $self->{app} = SDLx::App->new(
        title  => $self->{window_title},
        width  => $self->{window_width},
        height => $self->{window_height},
        delay  => 15
    );
};

our void::method $events = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self, my SDL::Event $event, my SDLx::App $app ) = @_;
    if ( $event->type() == SDL_QUIT ) { $app->stop(); }
};

our void::method $show = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self, my number $dt, my SDLx::App $app ) = @_;
    SDL::Video::fill_rect( $app, SDL::Rect->new( 0, 0, $app->w(), $app->h() ), 0 );

    my number $color_scaling_factor = 255 / $self->{iterations_max};
    my integer_arrayref $pixel_color = [ 0, 0, 0, 0 ];

    my $x = 0;
    my $y = 0;
    foreach my integer_arrayref $row ( @{ $self->{mandelbrot_set} } ) {
        foreach my integer $pixel ( @{$row} ) {
            $pixel_color->[3] = $pixel * $color_scaling_factor;  # blue only
            $app->[$x][$y] = $pixel_color;
            $x++;
        }
        $y++;
    }

=DISABLE
    my string $status = q{};
    my string $status_tmp;
    $status .= 'Time, Step: ' . ::number_to_string($self->{time_step_current}) . ' of ' . ::number_to_string($self->{time_step_max}) . "\n";
    $status_tmp = ::number_to_string($self->{delta_time} * $self->{time_step_current});
    $status_tmp =~ s/[.].*//xms;  # sim time, 0 characters after decimal
    $status .= 'Time, Sim:  ' . $status_tmp . ' of ' . ::number_to_string($self->{delta_time} * $self->{time_step_max}) . "\n";
    my number $time_elapsed = time() - $self->{time_start};
    $status_tmp = ::number_to_string($time_elapsed);
    $status_tmp =~ s/([.].{1}).*/$1/xms;  # real time elapsed, 1 character after decimal
    $status .= 'Time, Real: ' . $status_tmp;
    $status_tmp = ::number_to_string($time_elapsed * ($self->{time_step_max} / $self->{time_step_current}));
    $status_tmp =~ s/([.].{1}).*/$1/xms;  # real time total estimate, 1 character after decimal
    $status .= ' of ' . $status_tmp . "\n";
    $status_tmp =  ($self->{time_step_current} / $self->{time_step_max}) * 100;
    $status_tmp =~ s/[.].*//xms;  # sim time, 0 characters after decimal
    $status .= 'Completion: ' . $status_tmp . '%';
    $status_tmp = ::number_to_string($self->{time_step_current} / $time_elapsed);
    $status_tmp =~ s/[.].*//xms;  # steps per real time, 0 characters after decimal
    $status .= ' at ' . $status_tmp . ' Steps / Second' . "\n";

    # NEED FIX: remove hard-coded font path
    SDLx::Text->new(
        font    => 'fonts/VeraMono.ttf',
        size    => 15,
        color   => [255, 255, 255],
        text    => $status,
        x       => 10,
        y       => 10,
    )->write_to($app);
=cut

    $app->update();
};

=DISABLE
our void::method $move = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self, my number $dt, my SDLx::App $app, my number $t ) = @_;

    # don't overshoot your time_step_max
    if ( ( $self->{time_step_current} + $self->{time_steps_per_frame} ) > $self->{time_step_max} ) {
        $self->{time_steps_per_frame} = $self->{time_step_max} - $self->{time_step_current};
    }
    $self->{system}->advance_loop( $self->{delta_time}, $self->{time_steps_per_frame} );
    $self->{time_step_current} += $self->{time_steps_per_frame};
    if ( $self->{time_step_current} >= $self->{time_step_max} ) { $app->stop(); }
};

our void::method $render2d_video = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self ) = @_;

    $self->{app}->add_event_handler( sub { $self->events(@_) } );
    $self->{app}->add_show_handler( sub  { $self->show(@_) } );
    $self->{app}->add_move_handler( sub  { $self->move(@_) } );

    #    $self->{app}->fullscreen();
    $self->{app}->run();
};
=cut

our void::method $render2d_frame = sub {
    ( my MathPerl::Fractal::MandelbrotRenderer2D $self, my integer_arrayref_arrayref $mandelbrot_set, my integer $iterations_max ) = @_;
    $self->{mandelbrot_set} = $mandelbrot_set;
    $self->{iterations_max} = $iterations_max;

    $self->{app}->add_event_handler( sub { $self->events(@_) } );
    $self->{app}->add_show_handler( sub  { $self->show(@_) } );
#    $self->{app}->add_move_handler( sub  { $self->move(@_) } );

    #    $self->{app}->fullscreen();
    $self->{app}->run();
};

1;    # end of class
