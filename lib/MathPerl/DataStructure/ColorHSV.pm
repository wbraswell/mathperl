# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::ColorHSV;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Color);
use MathPerl::DataStructure::Color;

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::ColorRGB;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    hue        => my number $TYPED_hue        = undef,
    saturation => my number $TYPED_saturation = undef,
    value      => my number $TYPED_value      = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub hsv_to_rgb {
    { my MathPerl::DataStructure::ColorRGB $RETURN_TYPE };
    ( my MathPerl::DataStructure::ColorHSV $hsv) = @ARG;
    return $hsv->to_rgb();
}

# OO interface wrapper
sub to_rgb {
    { my MathPerl::DataStructure::ColorRGB::method $RETURN_TYPE };
    ( my MathPerl::DataStructure::ColorHSV $self) = @ARG;
    return hsv_raw_to_rgb( [ $self->{hue}, $self->{saturation}, $self->{value} ] );
}

# procedural interface wrapper
sub hsv_raw_to_rgb {
    { my MathPerl::DataStructure::ColorRGB $RETURN_TYPE };
    ( my number_arrayref $hsv_raw) = @ARG;
    my MathPerl::DataStructure::ColorRGB $retval = MathPerl::DataStructure::ColorRGB->new();
    my number_arrayref $retval_raw  = hsv_raw_to_rgb_raw($hsv_raw);
    $retval->{red}   = $retval_raw->[0];
    $retval->{green} = $retval_raw->[1];
    $retval->{blue}  = $retval_raw->[2];
    return;
}

sub hsv_raw_to_rgb_raw {
    { my number_arrayref $RETURN_TYPE };
    ( my number_arrayref $hsv_raw) = @ARG;
    my number_arrayref $retval;

    # START HERE: implement >> operators in RPerl
    # START HERE: implement >> operators in RPerl
    # START HERE: implement >> operators in RPerl

    my unsigned_integer $region;
    my unsigned_integer $remainder;
    my unsigned_integer $p;
    my unsigned_integer $q;
    my unsigned_integer $t;

    if ( $hsv_raw->[1] == 0 ) {
        $retval->[0] = $hsv_raw->[2];
        $retval->[1] = $hsv_raw->[2];
        $retval->[2] = $hsv_raw->[2];
        return $retval;
    }

    $region = $hsv_raw->[0] / 43;
    $remainder = ( $hsv_raw->[0] - ( $region * 43 ) ) * 6;

    $p = ( $hsv_raw->[2] * ( 255 - $hsv_raw->[1] ) ) >> 8;
    $q = ( $hsv_raw->[2] * ( 255 - ( ( $hsv_raw->[1] * $remainder ) >> 8 ) ) ) >> 8;
    $t = ( $hsv_raw->[2] * ( 255 - ( ( $hsv_raw->[1] * ( 255 - $remainder ) ) >> 8 ) ) ) >> 8;

    if ( $region == 0 ) {
        $retval->[0] = $hsv_raw->[2];
        $retval->[1] = $t;
        $retval->[2] = $p;
    }
    elsif ( $region == 1 ) {
        $retval->[0] = $q;
        $retval->[1] = $hsv_raw->[2];
        $retval->[2] = $p;
    }
    elsif ( $region == 2 ) {
        $retval->[0] = $p;
        $retval->[1] = $hsv_raw->[2];
        $retval->[2] = $t;
    }
    elsif ( $region == 3 ) {
        $retval->[0] = $p;
        $retval->[1] = $q;
        $retval->[2] = $hsv_raw->[2];
    }
    elsif ( $region == 4 ) {
        $retval->[0] = $t;
        $retval->[1] = $p;
        $retval->[2] = $hsv_raw->[2];
    }
    else {
        $retval->[0] = $hsv_raw->[2];
        $retval->[1] = $p;
        $retval->[2] = $q;
    }

    return $retval;
}

1;    # end of class
