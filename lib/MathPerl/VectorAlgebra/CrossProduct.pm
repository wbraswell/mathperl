# [[[ HEADER ]]]
use RPerl;
package MathPerl::VectorAlgebra::CrossProduct;
use strict;
use warnings;
our $VERSION = 0.002_000;

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
    $retval->set_x(($u->get_y() * $v->get_z()) - ($u->get_z() * $v->get_y()));
    $retval->set_y(($u->get_z() * $v->get_x()) - ($u->get_x() * $v->get_z()));
    $retval->set_z(($u->get_x() * $v->get_y()) - ($u->get_y() * $v->get_x()));
    return $retval;
};

our Vector3D $cross_product_vector = sub {
    ( my Vector $u, my Vector $v ) = @_;
    my integer $dimensions = scalar $u->get_head();
    # NEED ADD: check if dims of u match v, die otherwise
    
    my number_arrayref $u_head = $u->get_head();
    my number_arrayref $v_head = $v->get_head();

    my Vector $retval = Vector->new();
    my number_arrayref $retval_head = $retval->get_head();

    if ($dimensions == 3) {
        $retval_head->[0] = ($u_head->[1] * $v_head->[2]) - ($u_head->[2] * $v_head->[1]);
        $retval_head->[1] = ($u_head->[2] * $v_head->[0]) - ($u_head->[0] * $v_head->[2]);
        $retval_head->[2] = ($u_head->[0] * $v_head->[1]) - ($u_head->[1] * $v_head->[0]);
    }
    elsif ($dimensions == 7) {
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
