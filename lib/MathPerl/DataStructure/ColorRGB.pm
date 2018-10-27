# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::ColorRGB;
use strict;
use warnings;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Color);
use MathPerl::DataStructure::Color;

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT_OK = qw(rgb_to_hsv);

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::ColorHSV;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    red   => my number $TYPED_red   = undef,
    green => my number $TYPED_green = undef,
    blue  => my number $TYPED_blue  = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub rgb_to_hsv {
    { my MathPerl::DataStructure::ColorHSV $RETURN_TYPE };
    ( my MathPerl::DataStructure::ColorRGB $rgb) = @ARG;
    return $rgb->to_hsv();
}

# OO interface wrapper
sub to_hsv {
    { my MathPerl::DataStructure::ColorHSV::method $RETURN_TYPE };
    ( my MathPerl::DataStructure::ColorRGB $self) = @ARG;
    return rgb_raw_to_hsv( [ $self->{red}, $self->{green}, $self->{blue} ] );
}

# procedural interface wrapper
sub rgb_raw_to_hsv {
    { my MathPerl::DataStructure::ColorHSV $RETURN_TYPE };
    ( my number_arrayref $rgb_raw) = @ARG;
    my MathPerl::DataStructure::ColorHSV $retval = MathPerl::DataStructure::ColorHSV->new();
    my number_arrayref $retval_raw  = rgb_raw_to_hsv_raw($rgb_raw);
    $retval->{hue}   = $retval_raw->[0];
    $retval->{saturation} = $retval_raw->[1];
    $retval->{value}  = $retval_raw->[2];
    return;
}

sub rgb_raw_to_hsv_raw {
    { my number_arrayref $RETURN_TYPE };
    ( my number_arrayref $rgb_raw) = @ARG;
    my number_arrayref $retval;

# START HERE: complete algorithm
# START HERE: complete algorithm
# START HERE: complete algorithm

    return $retval;
}

1;                         # end of class
