# [[[ HEADER ]]]
package MathPerl::Fractal::Renderer2D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::Fractal::Mandelbrot;
use MathPerl::Fractal::Julia;
use Time::HiRes qw(time);
use POSIX qw(floor);
use SDL;
use SDL::Event;
use SDL::Video;
use SDLx::App;
use SDLx::Text;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    set             => my integer_arrayref_arrayref $TYPED_set = undef,
    set_name        => my string $TYPED_set_name               = undef,
    set_object      => my MathPerl::Fractal $TYPED_set_object  = undef,
    iterations_max  => my integer $TYPED_iterations_max        = undef,
    window_title    => my string $TYPED_window_title           = undef,
    window_width    => my integer $TYPED_window_width          = undef,
    window_height   => my integer $TYPED_window_height         = undef,
    x_min           => my number $TYPED_x_min                  = undef,
    x_max           => my number $TYPED_x_max                  = undef,
    y_min           => my number $TYPED_y_min                  = undef,
    y_max           => my number $TYPED_y_max                  = undef,
    zoom            => my number $TYPED_zoom                   = undef,
    move_factor     => my number $TYPED_move_factor            = 0.1,                  # NEED FIX: remove hard-coded values?
    zoom_factor     => my number $TYPED_zoom_factor            = 0.2,
    iterations_inc  => my integer $TYPED_iterations_inc        = 10,
    iterations_init => my integer $TYPED_iterations_init       = undef,
    automatic       => my boolean $TYPED_automatic             = 0,
    automatic_step  => my integer $TYPED_automatic_step        = undef,
    app             => my SDLx::App $TYPED_app                 = undef,
    color_invert    => my boolean $TYPED_color_invert          = undef,
    color_mode      => my integer $TYPED_color_mode            = undef,
    color_modes     => my integer_arrayref $TYPED_color_modes  = [ 0, 1, 127, 255 ],
    color_masks     => my integer_arrayref $TYPED_color_masks  = undef,
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $init = sub {
    ( my MathPerl::Fractal::Renderer2D $self, my string $set_name, my integer $x_pixel_count, my integer $y_pixel_count, my integer $iterations_max ) = @_;
    $self->{set_name}        = $set_name;
    $self->{window_title}    = 'Fractal Generator';
    $self->{window_width}    = $x_pixel_count;
    $self->{window_height}   = $y_pixel_count;
    $self->{iterations_max}  = $iterations_max;
    $self->{iterations_init} = $iterations_max;

    if    ( $self->{set_name} eq 'mandelbrot' ) { 
        $self->{set_object} = MathPerl::Fractal::Mandelbrot->new();
        $self->{real_arg} = ( $self->{set_object}->X_SCALE_MAX() - $self->{set_object}->X_SCALE_MIN() ) / $x_pixel_count;
        $self->{imaginary_arg} = ( $self->{set_object}->Y_SCALE_MAX() - $self->{set_object}->Y_SCALE_MIN() ) / $y_pixel_count;
    }
    elsif ( $self->{set_name} eq 'julia' )      { 
        $self->{set_object} = MathPerl::Fractal::Julia->new();
        $self->{real_arg} = -0.7;
        $self->{imaginary_arg} = 0.270_15;
    }
    else                                        { die 'Unknown fractal set name ' . $set_name . ', dying' . "\n"; }
    $self->{x_min} = $self->{set_object}->X_SCALE_MIN();
    $self->{x_max} = $self->{set_object}->X_SCALE_MAX();
    $self->{y_min} = $self->{set_object}->Y_SCALE_MIN();
    $self->{y_max} = $self->{set_object}->Y_SCALE_MAX();

    $self->{zoom}           = 1.0;
    $self->{automatic_step} = 0;
    $self->{color_invert}   = 0;
    $self->{color_mode}     = 5;                                                                                       # blue on black

    #    $self->{color_invert} = 1;  $self->{color_mode} = 3;  # red on white
    $self->{color_masks} = [
        $self->{color_modes}->[ $self->{color_mode} % 4 ],
        $self->{color_modes}->[ floor( ( $self->{color_mode} % 16 ) / 4 ) ],
        $self->{color_modes}->[ floor( ( $self->{color_mode} % 64 ) / 16 ) ]
    ];

    SDL::init(SDL_INIT_VIDEO);

    $self->{app} = SDLx::App->new(
        title  => $self->{window_title},
        width  => $self->{window_width},
        height => $self->{window_height},
        depth  => 32,                       # 32-bit color
        delay  => 25,                       # don't let SDL overload the CPU
    );
};

our void::method $events = sub {
    ( my MathPerl::Fractal::Renderer2D $self, my SDL::Event $event, my SDLx::App $app ) = @_;
    if ( $event->type() == SDL_QUIT ) { $app->stop(); }
    elsif ( $event->type == SDL_KEYDOWN ) {
        my string $key_name   = SDL::Events::get_key_name( $event->key_sym );
        my integer $mod_state = SDL::Events::get_mod_state();
        $self->process_keystroke( $app, $key_name, $mod_state );
    }
};

our void::method $process_keystroke = sub {
    ( my MathPerl::Fractal::Renderer2D $self, my SDLx::App $app, my string $key_name, my integer $mod_state ) = @_;

    #    print $key_name . ' ';

    if ( $key_name eq 'q' ) {    # QUIT
        $app->stop();
        return;
    }
    elsif ( $key_name eq 'up' ) {    # MOVE UP
        my number $y_move = ( $self->{y_max} - $self->{y_min} ) * $self->{move_factor};
        $self->{y_min} -= $y_move;
        $self->{y_max} -= $y_move;
    }
    elsif ( $key_name eq 'down' ) {    # MOVE DOWN
        my number $y_move = ( $self->{y_max} - $self->{y_min} ) * $self->{move_factor};
        $self->{y_min} += $y_move;
        $self->{y_max} += $y_move;
    }
    elsif ( $key_name eq 'left' ) {    # MOVE LEFT
        my number $x_move = ( $self->{x_max} - $self->{x_min} ) * $self->{move_factor};
        $self->{x_min} -= $x_move;
        $self->{x_max} -= $x_move;
    }
    elsif ( $key_name eq 'right' ) {    # MOVE RIGHT
        my number $x_move = ( $self->{x_max} - $self->{x_min} ) * $self->{move_factor};
        $self->{x_min} += $x_move;
        $self->{x_max} += $x_move;
    }
    elsif ( $key_name eq 'i' ) {        # ZOOM IN
        my number $zoom_change = $self->{zoom} * $self->{zoom_factor};
        $self->{zoom} = $self->{zoom} + $zoom_change;
        my number $x_zoom_tmp = ( $self->{set_object}->X_SCALE_MAX() - $self->{set_object}->X_SCALE_MIN() ) * ( 1 / $self->{zoom} );
        my number $x_zoom = ( ( $self->{x_max} - $self->{x_min} ) - $x_zoom_tmp ) / 2;
        my number $y_zoom_tmp = ( $self->{set_object}->Y_SCALE_MAX() - $self->{set_object}->Y_SCALE_MIN() ) * ( 1 / $self->{zoom} );
        my number $y_zoom = ( ( $self->{y_max} - $self->{y_min} ) - $y_zoom_tmp ) / 2;

        #        my number $x_zoom = (( $self->{x_max} - $self->{x_min} ) * $zoom_change ) / 2;  # BAD: floating-point rounding error?
        #        my number $y_zoom = (( $self->{y_max} - $self->{y_min} ) * $zoom_change ) / 2;
        $self->{x_min} += $x_zoom;
        $self->{x_max} -= $x_zoom;
        $self->{y_min} += $y_zoom;
        $self->{y_max} -= $y_zoom;
    }
    elsif ( $key_name eq 'o' ) {    # ZOOM OUT
        my number $zoom_change = $self->{zoom} * ( 1 - ( 1 / ( 1 + $self->{zoom_factor} ) ) );
        $self->{zoom} = $self->{zoom} - $zoom_change;
        my number $x_zoom_tmp
            = ( $self->{set_object}->X_SCALE_MAX() - $self->{set_object}->X_SCALE_MIN() ) * ( 1 / $self->{zoom} );
        my number $x_zoom = ( $x_zoom_tmp - ( $self->{x_max} - $self->{x_min} ) ) / 2;
        my number $y_zoom_tmp
            = ( $self->{set_object}->Y_SCALE_MAX() - $self->{set_object}->Y_SCALE_MIN() ) * ( 1 / $self->{zoom} );
        my number $y_zoom = ( $y_zoom_tmp - ( $self->{y_max} - $self->{y_min} ) ) / 2;
        $self->{x_min} -= $x_zoom;
        $self->{x_max} += $x_zoom;
        $self->{y_min} -= $y_zoom;
        $self->{y_max} += $y_zoom;
    }
    elsif ( ( ( $key_name eq '=' ) and ( $mod_state & KMOD_SHIFT ) ) or ( $key_name eq '+' ) ) {    # INCREASE ITERATIONS
        $self->{iterations_max} += $self->{iterations_inc};
    }
    elsif ( ( $key_name eq '-' ) and not( $mod_state & KMOD_SHIFT ) ) {                             # DECREASE ITERATIONS
        if ( $self->{iterations_max} > $self->{iterations_inc} ) {
            $self->{iterations_max} -= $self->{iterations_inc};
        }
    }
    elsif ( $key_name eq 'r' ) {                                                                    # RESET
        $self->{x_min}          = $self->{set_object}->X_SCALE_MIN();
        $self->{x_max}          = $self->{set_object}->X_SCALE_MAX();
        $self->{y_min}          = $self->{set_object}->Y_SCALE_MIN();
        $self->{y_max}          = $self->{set_object}->Y_SCALE_MAX();
        $self->{zoom}           = 1.0;
        $self->{iterations_max} = $self->{iterations_init};
    }
    elsif ( $key_name eq 'a' ) {                                                                    # AUTOMATIC ON
        $self->{automatic} = 1;
        return;
    }
    elsif ( $key_name eq 'space' ) {                                                                # AUTOMATIC OFF
        $self->{automatic} = 0;
        return;
    }
    elsif ( ( ( $key_name eq 'c' ) and ( $mod_state & KMOD_SHIFT ) ) or ( $key_name eq 'C' ) ) {    # COLOR INVERT
        $self->{color_invert} = not $self->{color_invert};
    }
    elsif ( $key_name eq 'c' ) {                                                                    # COLOR CYCLE
        while (1) {
            if   ( $self->{color_mode} < 63 ) { $self->{color_mode}++; }
            else                              { $self->{color_mode} = 1; }
            $self->{color_masks} = [
                $self->{color_modes}->[ $self->{color_mode} % 4 ],
                $self->{color_modes}->[ floor( ( $self->{color_mode} % 16 ) / 4 ) ],
                $self->{color_modes}->[ floor( ( $self->{color_mode} % 64 ) / 16 ) ]
            ];

            # require at least one color mask is 0, enabling pixel data
            if ( ( $self->{color_masks}->[0] == 0 ) or ( $self->{color_masks}->[1] == 0 ) or ( $self->{color_masks}->[2] == 0 ) ) { last; }
        }
    }
    else { return; }    # UNUSED KEYSTROKE

    $self->escape_time_render($app);    # only render additional frames when a change occurs
    $app->update();
};

our void::method $escape_time_render = sub {
    ( my MathPerl::Fractal::Renderer2D $self, my SDLx::App $app ) = @_;
    SDL::Video::fill_rect( $app, SDL::Rect->new( 0, 0, $app->w(), $app->h() ), 0 );    # avoid window resize on exit

    $self->{set} = $self->{set_object}->escape_time(
        $self->{real_arg},
        $self->{imaginary_arg},
        $self->{window_width},
        $self->{window_height},
        $self->{iterations_max},
        $self->{x_min}, $self->{x_max}, $self->{y_min}, $self->{y_max}, $self->{color_invert}
    );

    my $x = 0;
    my $y = 0;

    # pre-fetch color masks to speed up loop below
    my integer $color_mask_red   = $self->{color_masks}->[0];
    my integer $color_mask_green = $self->{color_masks}->[1];
    my integer $color_mask_blue  = $self->{color_masks}->[2];

    foreach my integer_arrayref $row ( @{ $self->{set} } ) {
        foreach my integer $pixel ( @{$row} ) {
            $app->[$x][$y] = [ undef, $color_mask_red || $pixel, $color_mask_green || $pixel, $color_mask_blue || $pixel ];
            $x++;
        }
        $x = 0;
        $y++;
    }

    my string $status = q{};
    my string $status_tmp;

    # DEV NOTE: both methods of displaying "Zoom" below are correct
    #    $status_tmp = ::number_to_string(($self->{set_object}->X_SCALE_MAX() - $self->{set_object}->X_SCALE_MIN()) / ($self->{x_max} - $self->{x_min}));
    #    if ($status_tmp !~ m/[.]/xms) { $status_tmp .= '.00'; }  # add 2 significant digits after decimal, if missing
    #    $status_tmp =~ s/([.]..).*/$1/xms;  # limit to exactly 2 significant digits after decimal
    #    $status .= 'ZoomCalc:   ' . $status_tmp . 'x' . "\n";
    $status_tmp = ::number_to_string( $self->{zoom} );
    if ( $status_tmp !~ m/[.]/xms ) { $status_tmp .= '.00'; }    # add 2 significant digits after decimal, if missing
    $status_tmp =~ s/([.]..).*/$1/xms;                           # limit to exactly 2 significant digits after decimal
    $status .= 'Zoom:       ' . $status_tmp . 'x' . "\n";
    $status .= 'Iterations: ' . ::integer_to_string( $self->{iterations_max} ) . "\n";

    # scale font within limits
    my integer $font_size = floor $self->{window_height} / 12;
    if    ( $font_size < 10 ) { $font_size = 10; }
    elsif ( $font_size > 20 ) { $font_size = 20; }
    my integer_arrayref $font_color;
    if   ( $self->{color_invert} ) { $font_color = [ 0,   0,   0 ]; }      # black text
    else                           { $font_color = [ 255, 255, 255 ]; }    # white text

    # NEED FIX: remove hard-coded font path
    SDLx::Text->new(
        font  => 'fonts/VeraMono.ttf',
        size  => $font_size,
        color => $font_color,
        text  => $status,
        x     => 10,
        y     => 10,
    )->write_to($app);

};

our void::method $move = sub {
    ( my MathPerl::Fractal::Renderer2D $self, my number $dt, my SDLx::App $app, my number $t ) = @_;

    #    print 'in move(), received $dt = ' . $dt . ', $t = ' . $t . "\n";
    #    print 'in move(), have $self->{automatic_step} = ' . $self->{automatic_step} . "\n";

    my string_arrayref $auto_moves
        = [
        qw(r up up right right i i i right up i i i i i up i i i i i i right up i i i i i i i i + + i i i i i i i + i + i i i i + right i i i i i + i i i i i i i i i + i i i i i i + i i + i i i i i i i i i i i + i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i)
        ];

    if ( $self->{automatic} ) {

        # check for SPACE keystroke both in events() and here in move(), double keystroke checking is standard practice
        SDL::Events::pump_events();
        my $keys_ref = SDL::Events::get_key_state();
        if ( $keys_ref->[SDLK_SPACE] ) { $self->{automatic} = 0; }

        # simply stop when end of $auto_moves is reached
        if ( $self->{automatic_step} >= ( scalar @{$auto_moves} ) ) {
            $self->{automatic}      = 0;
            $self->{automatic_step} = 0;
        }
        else {
            $self->process_keystroke( $app, $auto_moves->[ $self->{automatic_step} ], 0 );
            $self->{automatic_step}++;
        }

        $self->escape_time_render($app);    # only render additional frames when a change occurs
        $app->update();
    }
};

our void::method $render2d_video = sub {
    ( my MathPerl::Fractal::Renderer2D $self ) = @_;
    $self->escape_time_render( $self->{app} );    # render first frame
    $self->{app}->update();

    $self->{app}->add_event_handler( sub { $self->events(@_) } );
    $self->{app}->add_move_handler( sub  { $self->move(@_) } );

    #    $self->{app}->add_show_handler( sub { $self->{app}->update() } );

    #    $self->{app}->fullscreen();
    $self->{app}->run();
};

1;    # end of class
