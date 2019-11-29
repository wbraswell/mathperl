# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Shape3D::Sphere;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Shape3D);
use MathPerl::Geometry::Shape3D;

# [[[ CRITICS ]]]
# <<< CHANGE_ME: delete unused directives >>>
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]
use MathPerl::Geometry::Point3D;
use MathPerl::Geometry::AffineTransformation3D;
use MathPerl::Geometry::Intersection3D;


# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    center_point => my MathPerl::Geometry::Point3D $TYPED_center_point = undef, 
    radius => my number $TYPED_radius = undef, 

    color => my PhysicsPerl::Energy::Light::Color $TYPED_color = undef,

    num_hits => my unsigned_integer $TYPED_num_hits = undef,
    soonest_hit => my integer $TYPED_soonest_hit = undef,
    intersections => => my MathPerl::Geometry::Intersection3D_arrayref $TYPED_intersections = undef,  # no initial size, no  initial values

    transform => my MathPerl::Geometry::AffineTransformation3D $TYPED_transform = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Shape3D::Sphere $self) = @ARG;

	$self->{num_hits} = 0;
	$self->{soonest_hit} = -1;
	$self->{intersections} = [];
	
	$self->{center_point} = MathPerl::Geometry::Point3D->new();
	$self->{radius} = 1;
	$self->{color} = PhysicsPerl::Energy::Light::Color->new();

	$self->{transform} = MathPerl::Geometry::AffineTransformation3D->new();

    return;
}


sub generate_transform
{
	my $self = shift;

	$self->{transform}->init();

	# translate the sphere around space
	$self->{transform}->translate($self->{center_point});

    # UPGRADE HERE: implement rotate() and shear() in AffineTransformation3D
    # UPGRADE HERE: implement rotate() and shear() in AffineTransformation3D
    # UPGRADE HERE: implement rotate() and shear() in AffineTransformation3D
 
	# rotate the sphere about it's axes
#	$self->{transform}->rotate();

	# shear the sphere
#	$self->{transform}->shear();
#
	# scale the sphere up or down
    my MathPerl::Geometry::Point3D $scale_radius = MathPerl::Geometry::Point3D->new();
    $scale_radius->{x} = $self->{radius};
    $scale_radius->{y} = $self->{radius};
    $scale_radius->{z} = $self->{radius};
	$self->{transform}->scale($scale_radius);

	# invert transform
	$self->{transform}->invert();
}


sub intersect
{
	my $self = shift;

	# reset all hit info
	$self->{intersections} = [];
	$self->{num_hits} = 0;
	$self->{soonest_hit} = -1;

	# current ray to test for intersection w/
	my $in_ray = shift;
	# wash in_ray direction of over-precise data
	$in_ray->direction->v_to_xyz();
	$in_ray->direction->xyz_to_v();

	my $visible_hits = 0;

$self->debugger->start_debug();
$self->debug("\nin Sphere->intersect(), NEW INTERSECTION TEST\n");
	
#$self->debug("in Sphere->intersect(), have \$in_ray->{origin} = \n" . Dumper($in_ray->{origin}) . "\n");
#$self->debug("in Sphere->intersect(), have \$in_ray->{direction} = \n" . Dumper($in_ray->{direction}) . "\n");
$self->debug("in Sphere->intersect(), have \$self->{transform}->{m} = \n" . $self->{transform}->{m} . "\n");
#$self->debug("in Sphere->intersect(), have \$self->{transform}->{m_inverse} = \n" . $self->{transform}->{m_inverse} . "\n");
#$self->debug("in Sphere->intersect(), have identity(?) = \n" . ($self->{transform}->{m_inverse} * $self->{transform}->{m}) . "\n");

	# apply inverse transformation to ray
	my $inverse_transform = MathPerl::Geometry::AffineTransformation3D->new();
	$inverse_transform->{m} = $self->{transform}->m_inverse->clone();
	my $transformed_ray = $in_ray->{transform}($inverse_transform);

$self->debug("in Sphere->intersect(), have \$in_ray->direction->{x, y, z} = {" . $in_ray->direction->{x} . ", " . $in_ray->direction->{y} . ", " . $in_ray->direction->{z} . "}\n");
$self->debug("in Sphere->intersect(), have \$in_ray->origin->{x, y, z} = {" . $in_ray->origin->{x} . ", " . $in_ray->origin->{y} . ", " . $in_ray->origin->{z} . "}\n");
$self->debug("in Sphere->intersect(), have \$transformed_ray->direction->{x, y, z} = {" . $transformed_ray->direction->{x} . ", " . $transformed_ray->direction->{y} . ", " . $transformed_ray->direction->{z} . "}\n");
$self->debug("in Sphere->intersect(), have \$transformed_ray->origin->{x, y, z} = {" . $transformed_ray->origin->{x} . ", " . $transformed_ray->origin->{y} . ", " . $transformed_ray->origin->{z} . "}\n");

	# does the transformed ray intersect w/ a generic sphere?
	my $A = $transformed_ray->direction->square();
	my $B = 2 * ($transformed_ray->origin->dot($transformed_ray->{direction}));
	my $C = $transformed_ray->origin->square() - 1;

$self->debug("in Sphere->intersect(), w/ (\$A = $A), (\$B = $B), and (\$C = $C)\n");

	my $discriminant = ($B * $B) - (4 * $A * $C);

$self->debug("in Sphere->intersect(), w/ \$discriminant = $discriminant\n");

	if ($discriminant < 0)
	{  # ray DOES NOT intersect sphere
$self->debug("in Sphere->intersect(), ray MISSES\n");
$self->debugger->end_debug();
		return 0;
	}
	elsif ($discriminant == 0)
	{  # ray is TANGENT to sphere
$self->debug("in Sphere->intersect(), ray IS TANGENT\n");

# causing to divide by ($A == 0);
#		$self->{intersections}[$self->{num_hits}] = MathPerl::Geometry::Intersection3D->new();
#		$self->{intersections}[$self->{num_hits}]->{time} = (-1 * $B) / $A;
#		$self->{num_hits} += 1;

$self->debugger->end_debug();
		return 0;
	}
	elsif ($discriminant > 0)
	{  # ray PASSES THROUGH sphere
$self->debug("in Sphere->intersections, ray PASSES THROUGH\n");

		my $hit_time;
		my $hit_point;

		my $discriminant_sqrt = sqrt($discriminant);

		# populate first Intersection (hit) record entry
		$self->{intersections}[$self->{num_hits}] = MathPerl::Geometry::Intersection3D->new();
		$hit_time = ((-1 * $B) - $discriminant_sqrt) / (2 * $A);
$self->debug("in Sphere->intersect(), have first \$hit_time = $hit_time\n");
		$self->{intersections}[$self->{num_hits}]->{time} = $hit_time;
		$visible_hits++ if ($self->{intersections}[$self->{num_hits}]->{time} > 0);	
		$hit_point = $in_ray->find_position($hit_time);	
		$self->{intersections}[$self->{num_hits}]->{point} = $hit_point;
	# THIS NORMAL ONLY VALID FOR SCALED, TRANSLATED (AND MAYBE ROTATED) SPHERES!!!
		$self->{intersections}[$self->{num_hits}]->normal->set_triplet($hit_point->{x}, $hit_point->{y}, $hit_point->{z});
		$self->{num_hits}++;

		# populate second Intersection (hit) record entry
		$self->{intersections}[$self->{num_hits}] = MathPerl::Geometry::Intersection3D->new();
		$hit_time = ((-1 * $B) + $discriminant_sqrt) / (2 * $A);
$self->debug("in Sphere->intersect(), have second \$hit_time = $hit_time\n");
		$self->{intersections}[$self->{num_hits}]->{time} = $hit_time;
		$visible_hits++ if ($self->{intersections}[$self->{num_hits}]->{time} > 0);	
		$hit_point = $in_ray->find_position($hit_time);	
		$self->{intersections}[$self->{num_hits}]->{point} = $hit_point;
	# THIS NORMAL ONLY VALID FOR SCALED, TRANSLATED (AND MAYBE ROTATED) SPHERES!!!
		$self->{intersections}[$self->{num_hits}]->normal->set_triplet($hit_point->{x}, $hit_point->{y}, $hit_point->{z});
		$self->{num_hits}++;

$self->debug("in Sphere->intersect(), returning \$visible_hits = $visible_hits\n");
$self->debugger->end_debug();
		return $visible_hits;
	}
}

1;  # end of class
