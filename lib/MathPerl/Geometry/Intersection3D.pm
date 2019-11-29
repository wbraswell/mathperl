# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Intersection3D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Intersection);
use MathPerl::Geometry::Intersection;

# [[[ CRITICS ]]]
# <<< CHANGE_ME: delete unused directives >>>
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]
use MathPerl::Geometry::Point3D;
use MathPerl::Geometry::Vector3D;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    time => my integer $TYPED_time = undef,
    point => my MathPerl::Geometry::Point3D $TYPED_point = undef,
    normal => my MathPerl::Geometry::Vector3D $TYPED_normal = undef,

# UPGRADE HERE: when are entering and surface actually used, and what types are they???
# UPGRADE HERE: when are entering and surface actually used, and what types are they???
# UPGRADE HERE: when are entering and surface actually used, and what types are they???

    # ray is entering entity
#    entering => undef,

    # surface hit
#    surface => undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	$self->{time} = -1;
	$self->{point} = MathPerl::Geometry::Point3D->new();
	$self->{normal} = MathPerl::Geometry::Vector3D->new();

	# entering and surface not used for all Entities
#	$self->{entering} = 'unknown';
#	$self->{surface} = -1;

    return;
}

1;  # end of class
