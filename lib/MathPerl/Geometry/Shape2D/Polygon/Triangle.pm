# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::Shape2D::Polygon::Triangle;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::Shape2D::Polygon);
use MathPerl::Geometry::Shape2D::Polygon;

# [[[ CRITICS ]]]
# <<< CHANGE_ME: delete unused directives >>>
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]
use MathPerl::Geometry::Point3D;
use MathPerl::Geometry::Line;
use MathPerl::Geometry::Plane;
use MathPerl::Geometry::Intersection3D;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    corner_a => my MathPerl::Geometry::Point3D $TYPED_corner_a = undef, 
    corner_b => my MathPerl::Geometry::Point3D $TYPED_corner_b = undef, 
    corner_c => my MathPerl::Geometry::Point3D $TYPED_corner_c = undef, 

    # store sides for intersect() optimization ;^>
    side_a => my MathPerl::Geometry::Line $TYPED_side_a = undef,
    side_b => my MathPerl::Geometry::Line $TYPED_side_b = undef,

    epsilon => my number $TYPED_epsilon = 0.000_01,
    enable_culling => my boolean $TYPED_enable_culling = undef,

    color => my PhysicsPerl::Energy::Light::Color $TYPED_color = undef,

    num_hits => my unsigned_integer $TYPED_num_hits = undef,
    soonest_hit => my integer $TYPED_soonest_hit = undef,
    intersections => => my MathPerl::Geometry::Intersection3D_arrayref $TYPED_intersections = undef,  # no initial size, no  initial values

    # no need for Affine transform, so leave disabled
#    transform => undef
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Shape2D::Polygon::Triangle $self ) = @ARG;

    $self->{num_hits} = 0;
    $self->{soonest_hit} = -1;
    $self->{intersections} = [];
    
    $self->{corner_a} = MathPerl::Geometry::Point3D->new();
    $self->{corner_b} = MathPerl::Geometry::Point3D->new();
    $self->{corner_c} = MathPerl::Geometry::Point3D->new();

    $self->{side_a} = MathPerl::Geometry::Line->new();
    $self->{side_b} = MathPerl::Geometry::Line->new();

    # no culling == two-sided (faced) triangles
    $self->{enable_culling} = 0;

    $self->{color} = PhysicsPerl::Energy::Light::Color->new();

    return;
}


sub intersect
{
    { my boolean::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Shape2D::Polygon::Triangle $self, my MathPerl::Geometry::Ray3D $in_ray ) = @ARG;

    # DEV NOTE: assume pre-process call to find_sides()

    # reset all hit info
    $self->{intersections} = [];
    $self->{num_hits} = 0;
    $self->{soonest_hit} = -1;

    # barycetric coordinates w/in triangle
    my number $u_barycentric;
    my number $v_barycentric;

    # time of intersection
    my integer $time;

    # beging calculating determinant, also used for $u_barycentric
    my MathPerl::Geometry::Vector3d $p_vector = $in_ray->{direction}->cross($self->{side_b}->{difference_vector}); 
    
    # if determinant is near zero, ray lies in plane of triangle
    my number $determinant = $self->{side_a}->{difference_vector}->dot($p_vector);

print {*STDERR} "in Triangle->intersect(), have \$determinant = $determinant\n";

    if ($self->{enable_culling})
    { # cull back-facing (one-sided) triangles
        if ($determinant < $self->{epsilon}) {
            return 0;
        }

        # distance from $corner_a to ray's origin
        my MathPerl::Geometry::Vector3D $t_vector = $in_ray->{origin}->generate_vector($self->{corner_a});

        # calculate $u_barycentric and test bounds
        $u_barycentric = $t_vector->dot($p_vector);
        if (($u_barycentric < 0) || ($u_barycentric > $determinant)) {
            return 0;
        }

        # prepare to test $v_barycentric
        my MathPerl::Geometry::Vector3D $q_vector = $t_vector->cross($self->{side_a}->{difference_vector});

         # calculate $u_barycentric and test bounds
        $v_barycentric = $in_ray->{direction}->dot($q_vector);
        if (($v_barycentric < 0) || (($v_barycentric + $u_barycentric) > $determinant)) {
            return 0;
        }

        # calculate $time, scale parameters, the ray intersects the triangle
        $time = $self->{side_c}->{difference_vector}->dot($q_vector);

        my number $inverted_determinant = 1 / $determinant;
        $time *= $inverted_determinant;
        $u_barycentric *= $inverted_determinant;
        $v_barycentric *= $inverted_determinant;
    }
    else
    {  # allow for two-sided triangles

        if (($determinant > (-1 * $self->{epsilon})) && ($determinant < $self->{epsilon})) {
            return 0;
        }

print {*STDERR} "in Triangle->invert(), Ray not in Triangle's plane\n";

        my number $inverted_determinant = 1 / $determinant;

        # distance from $corner_a to origin
        my MathPerl::Geometry::Vector3D $t_vector = $in_ray->{origin}->generate_vector($self->{corner_a});
print {*STDERR} "in Triangle->invert(), have \$t_vector = \n" . Dumper($t_vector) . "\n";

        # calculate $u_barycentric and test bounds
        $u_barycentric = $t_vector->dot($p_vector) * $inverted_determinant;
print {*STDERR} "in Triangle->invert(), have \$u_barycentric = \n" . Dumper($u_barycentric) . "\n";
        if (($u_barycentric < 0) || ($u_barycentric > 1)) {
            return 0;
        }

        # prepare to test $v_barycentric parameter
        my MathPerl::Geometry::Vector3D $q_vector = $t_vector->cross($self->{side_a}->{difference_vector});

        # calculate $v_barycentric and test bounds
        $v_barycentric = $in_ray->{direction}->dot($q_vector) * $inverted_determinant;
        if (($v_barycentric < 0) || (($v_barycentric + $u_barycentric) > 1)) {
            return 0;
        }

        $time = $self->{side_b}->{difference_vector}->dot($q_vector) * $inverted_determinant;
    }

    # planar triangles should only intersect rays once...
    $self->{soonest_hit} = $self->{num_hits};

    # populate Intersection (hit) record
    $self->{intersections}[$self->{num_hits}] = MathPerl::Geometry::Intersection3D->new();
    $self->{intersections}[$self->{num_hits}]->{time} = $time;

    # two different ways to find hit point:
    # 1. using the ray's position at time
    $self->{intersections}[$self->{num_hits}]->{point} = $in_ray->find_position($time);
    # ...OR...
    # 2. by transforming the barycentric coords into cartesian coords
#    my number $w_barycentric = 1 - ($u_barycentric + $v_barycentric);
#    $self->{intersections}[$self->{num_hits}]->point->{x} = ($w_barycentric * $self->corner_a->{x}) + ($u_barycentric * $self->corner_b->{x}) + ($v_barycentric * $self->corner_c->{x});
#    $self->{intersections}[$self->{num_hits}]->point->{y} = ($w_barycentric * $self->corner_a->{y}) + ($u_barycentric * $self->corner_b->{y}) + ($v_barycentric * $self->corner_c->{y});
#    $self->{intersections}[$self->{num_hits}]->point->{z} = ($w_barycentric * $self->corner_a->{z}) + ($u_barycentric * $self->corner_b->{z}) + ($v_barycentric * $self->corner_c->{z});

    $self->{num_hits}++;

    # successful intersection
    return 1;
}


# pre-process triangle's sides to optimize intersect()
sub find_sides
{
    { my void::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Shape2D::Polygon::Triangle $self ) = @ARG;

    $self->{side_a}->{point_a} = $self->{corner_b};
    $self->{side_a}->{point_b} = $self->{corner_a};
    $self->{side_a}->find_difference();

    $self->{side_b}->{point_a} = $self->{corner_c};
    $self->{side_b}->{point_b} = $self->{corner_a};
    $self->{side_b}->find_difference();

print {*STDERR} "in Triangle->find_sides, have \$self->{side_a} = \n";
print {*STDERR} Dumper($self->{side_a}) . "\n";

    return;
}


# only find normal vector if necessary (shading)
sub find_normal
{
    { my void::method $RETURN_TYPE };
    ( my MathPerl::Geometry::Shape2D::Polygon::Triangle $self ) = @ARG;

    my MathPerl::Geometry::Plane $plane = MathPerl::Geometry::Plane->new();

    $plane->{point_a} = $self->{corner_a};
    $plane->{point_b} = $self->{corner_b};
    $plane->{point_c} = $self->{corner_c};

    $plane->three_point_to_point_normal();
    
    for (my unsigned_integer $i = 0; $i < $self->{num_hits}; $i++)
    {
        # store normal vector in all Intersection (hit) records
        $self->{intersections}[$i]->{normal} = $plane->{normal};
    }

    return;
}

1;    # end of class

