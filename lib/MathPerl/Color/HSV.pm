# [[[ HEADER ]]]
use RPerl;

package MathPerl::Color::HSV;
use strict;
use warnings;
our $VERSION = 0.000_001;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Color);
use MathPerl::Color;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    red   => my number $TYPED_red   = undef,
    green => my number $TYPED_green = undef,
    blue  => my number $TYPED_blue  = undef,
};

our MathPerl::Color::RGB $hsv_to_rgb = sub {
    ( my MathPerl::Color::HSV $hsv) = @_;
    return $hsv->to_rgb();
};

# OO interface wrapper
our MathPerl::Color::RGB_method $to_rgb = sub {
    ( my MathPerl::Color::HSV $self) = @_;
    return hsv_raw_to_rgb( [ $self->{hue}, $self->{saturation}, $self->{value} ] );
};

# procedural interface wrapper
our MathPerl::Color::RGB $hsv_raw_to_rgb = sub {
    ( my number_arrayref $hsv_raw) = @_;
    my MathPerl::Color::RGB $retval = MathPerl::Color::RGB->new();
    my number_arrayref $retval_raw  = hsv_raw_to_rgb_raw($hsv_raw);
    $retval->{red}   = $retval_raw->[0];
    $retval->{green} = $retval_raw->[1];
    $retval->{blue}  = $retval_raw->[2];
    return;
};

our number_arrayref $hsv_raw_to_rgb_raw = sub {
    ( my number_arrayref $hsv) = @_;
    my MathPerl::Color::RGB $retval;

# START HERE: determine solution to >> operators
# START HERE: determine solution to >> operators
# START HERE: determine solution to >> operators

    my unsigned_integer $region;
    my unsigned_integer $remainder;
    my unsigned_integer $p;
    my unsigned_integer $q;
    my unsigned_integer $t;

    if ( $hsv->[1] == 0 ) {
        $retval->{red}   = $hsv->[2];
        $retval->{green} = $hsv->[2];
        $retval->{blue}  = $hsv->[2];
        return $retval;
    }

    $region = $hsv->[0] / 43;
    $remainder = ( $hsv->[0] - ( $region * 43 ) ) * 6;

    $p = ( $hsv->[2] * ( 255 - $hsv->[1] ) ) >> 8;
    $q = ( $hsv->[2] * ( 255 - ( ( $hsv->[1] * remainder ) >> 8 ) ) ) >> 8;
    $t = ( $hsv->[2] * ( 255 - ( ( $hsv->[1] * ( 255 - remainder ) ) >> 8 ) ) ) >> 8;

    if ( $region == 0 ) {
        $retval->{red}   = $hsv->[2];
        $retval->{green} = $t;
        $retval->{blue}  = $p;
    }
    elsif ( $region == 1 ) {
        $retval->{red} = q; $retval->{green} = $hsv->[2]; $retval->{blue} = p;
    }
    elsif ( $region == 2 ) {
        $retval->{red}   = $p;
        $retval->{green} = $hsv->[2];
        $retval->{blue}  = $t;
    }
    elsif ( $region == 3 ) {
        $retval->{red}   = $p;
        $retval->{green} = $q;
        $retval->{blue} = $hsv->[2];
    }
    elsif ( $region == 4 ) {
        $retval->{red}   = $t;
        $retval->{green} = $p;
        $retval->{blue}  = $hsv->[2];
    }
    else {
        $retval->{red}   = $hsv->[2];
        $retval->{green} = $p;
        $retval->{blue}  = $q;
    }

    return $retval;
};

1;                         # end of class
