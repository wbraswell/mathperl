# [[[ HEADER ]]]
use RPerl;
package MathPerl::VectorAlgebra::CrossProduct;
use strict;
use warnings;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Operation);
use MathPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use MathPerl::DataStructure::Vector;
use MathPerl::DataStructure::Vector3D;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub cross_product_vector3d {
    { my Vector3D $RETURN_TYPE };
    ( my Vector3D $u, my Vector3D $v ) = @ARG;
    my Vector3D $retval = Vector3D->new();

    # DEV NOTE: there is no concept of defined vs undefined values in C++, 
    # can not add error checking to ensure all elements are defined, we assume they all are defined

    # OO properties direct access mechanism, does NOT work if dependency files are compiled but this file is not
    $retval->{x} = ($u->{y} * $v->{z}) - ($u->{z} * $v->{y});
    $retval->{y} = ($u->{z} * $v->{x}) - ($u->{x} * $v->{z});
    $retval->{z} = ($u->{x} * $v->{y}) - ($u->{y} * $v->{x});

    # OO properties accessor/mutator mechanism, DOES work if dependency files are compiled but this file is not
#    $retval->set_x(($u->get_y() * $v->get_z()) - ($u->get_z() * $v->get_y()));
#    $retval->set_y(($u->get_z() * $v->get_x()) - ($u->get_x() * $v->get_z()));
#    $retval->set_z(($u->get_x() * $v->get_y()) - ($u->get_y() * $v->get_x()));
    return $retval;
}

sub cross_product_vector {
    { my Vector3D $RETURN_TYPE };
    ( my Vector $u, my Vector $v ) = @ARG;

    # OO properties direct access mechanism
    my number_arrayref $u_head = $u->{head};
    my number_arrayref $v_head = $v->{head};
    my integer $u_dimensions = scalar $u_head;
    my integer $v_dimensions = scalar $v_head;
 
    # OO properties accessor/mutator mechanism
#    my number_arrayref $u_head = $u->get_head();
#    my number_arrayref $v_head = $v->get_head();
#    my integer $u_dimensions = scalar $u_head;
#    my integer $v_dimensions = scalar $v_head;

    if ($u_dimensions != $v_dimensions) {
        croak 'ERROR EMPVACP00: Dimensions mis-match, input vector $u contains ' . $u_dimensions . 
            ' elements and input vector $v contains ' . $v_dimensions . ' elements, croaking';
    }

    my Vector $retval = Vector->new();
    my number_arrayref $retval_head = $retval->{head};  # OO properties direct access mechanism
#    my number_arrayref $retval_head = $retval->get_head();  # OO properties accessor/mutator mechanism

    if ($u_dimensions == 3) {
        $retval_head->[0] = ($u_head->[1] * $v_head->[2]) - ($u_head->[2] * $v_head->[1]);
        $retval_head->[1] = ($u_head->[2] * $v_head->[0]) - ($u_head->[0] * $v_head->[2]);
        $retval_head->[2] = ($u_head->[0] * $v_head->[1]) - ($u_head->[1] * $v_head->[0]);
    }
    elsif ($u_dimensions == 7) {
        $retval_head->[0] = (($u_head->[1] * $v_head->[3]) - ($u_head->[3] * $v_head->[1])) + 
                            (($u_head->[2] * $v_head->[6]) - ($u_head->[6] * $v_head->[2])) +
                            (($u_head->[4] * $v_head->[5]) - ($u_head->[5] * $v_head->[4]));
        $retval_head->[1] = (($u_head->[2] * $v_head->[4]) - ($u_head->[4] * $v_head->[2])) + 
                            (($u_head->[3] * $v_head->[0]) - ($u_head->[0] * $v_head->[3])) +
                            (($u_head->[5] * $v_head->[6]) - ($u_head->[6] * $v_head->[5]));
        $retval_head->[2] = (($u_head->[3] * $v_head->[5]) - ($u_head->[5] * $v_head->[3])) + 
                            (($u_head->[4] * $v_head->[1]) - ($u_head->[1] * $v_head->[4])) +
                            (($u_head->[6] * $v_head->[0]) - ($u_head->[0] * $v_head->[6]));
        $retval_head->[3] = (($u_head->[4] * $v_head->[6]) - ($u_head->[6] * $v_head->[4])) + 
                            (($u_head->[5] * $v_head->[2]) - ($u_head->[2] * $v_head->[5])) +
                            (($u_head->[0] * $v_head->[1]) - ($u_head->[1] * $v_head->[0]));
        $retval_head->[4] = (($u_head->[5] * $v_head->[0]) - ($u_head->[0] * $v_head->[5])) + 
                            (($u_head->[6] * $v_head->[3]) - ($u_head->[3] * $v_head->[6])) +
                            (($u_head->[1] * $v_head->[2]) - ($u_head->[2] * $v_head->[1]));
        $retval_head->[5] = (($u_head->[6] * $v_head->[1]) - ($u_head->[1] * $v_head->[6])) + 
                            (($u_head->[0] * $v_head->[4]) - ($u_head->[4] * $v_head->[0])) +
                            (($u_head->[2] * $v_head->[3]) - ($u_head->[3] * $v_head->[2]));
        $retval_head->[6] = (($u_head->[0] * $v_head->[2]) - ($u_head->[2] * $v_head->[0])) + 
                            (($u_head->[1] * $v_head->[5]) - ($u_head->[5] * $v_head->[1])) +
                            (($u_head->[3] * $v_head->[4]) - ($u_head->[4] * $v_head->[3]));
    }
    else {
        croak 'ERROR EMPVACP01: Dimensions unsupported, input vectors contain ' . $u_dimensions . ' elements, only 3 and 7 supported, croaking';
    }
    return $retval;
}

1;    # end of class
