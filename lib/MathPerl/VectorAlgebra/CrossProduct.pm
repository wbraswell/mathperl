# [[[ HEADER ]]]
use RPerl;
package MathPerl::VectorAlgebra::CrossProduct;
use strict;
use warnings;
our $VERSION = 0.003_000;

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

our Vector3D $cross_product_vector3d = sub {
    ( my Vector3D $u, my Vector3D $v ) = @_;
    my Vector3D $retval = Vector3D->new();

    # NEED ADD ERROR CHECKING, if elements are all defined

    # OO properties direct access mechanism, does NOT work if dependency files are compiled but this file is not
    $retval->{x} = ($u->{y} * $v->{z}) - ($u->{z} * $v->{y});
    $retval->{y} = ($u->{z} * $v->{x}) - ($u->{x} * $v->{z});
    $retval->{z} = ($u->{x} * $v->{y}) - ($u->{y} * $v->{x});

    # OO properties accessor/mutator mechanism, DOES work if dependency files are compiled but this file is not
#    $retval->set_x(($u->get_y() * $v->get_z()) - ($u->get_z() * $v->get_y()));
#    $retval->set_y(($u->get_z() * $v->get_x()) - ($u->get_x() * $v->get_z()));
#    $retval->set_z(($u->get_x() * $v->get_y()) - ($u->get_y() * $v->get_x()));
    return $retval;
};

our Vector3D $cross_product_vector = sub {
    ( my Vector $u, my Vector $v ) = @_;

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
        croak 'ERROR EMPVACPxx: Dimension mis-match, input vector $u contains ' . $u_dimensions . 
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
        die 'NEED ERROR MESSAGE';
    }
    return $retval;
};

1;    # end of class
