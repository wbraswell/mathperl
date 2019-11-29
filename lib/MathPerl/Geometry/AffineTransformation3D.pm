# [[[ HEADER ]]]
use RPerl;
package MathPerl::Geometry::AffineTransformation3D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::Geometry::AffineTransformation);
use MathPerl::Geometry::AffineTransformation;

# [[[ INCLUDES ]]]

# START HERE: remove external dependency Math::MatrixReal!!!
# START HERE: remove external dependency Math::MatrixReal!!!
# START HERE: remove external dependency Math::MatrixReal!!!

use Math::MatrixReal;  # transform needs 4x4 matrix

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    # main transform matrix
    m => my Math::MatrixReal $TYPED_m = undef,
    m_inverse => my Math::MatrixReal $TYPED_m_inverse = undef,

    # backup values
    m_bak => my Math::MatrixReal $TYPED_m_backup = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	$self->{m} = Math::MatrixReal->new_from_string(<<'MATRIX');
[ 1  0  0  0 ]
[ 0  1  0  0 ]
[ 0  0  1  0 ]
[ 0  0  0  1 ]
MATRIX

    return;
}


sub translate
{
    { my void::method $RETURN_TYPE };
    ( my object $self, my MathPerl::Geometry::Point3D $translate_point) = @ARG;

	my $transform = MathPerl::Geometry::AffineTransformation3D->new();


# ONE OF THESE TWO IS WRONG!!!
#	$transform->{m} = Math::MatrixReal->new_from_string(<<"MATRIX");
#[ 1  0  0  0 ]
#[ 0  1  0  0 ]
#[ 0  0  1  0 ]
#[ $translate_point->{x}  $translate_point->{y}  $translate_point->{z}  1 ]
#MATRIX

	$transform->{m} = Math::MatrixReal->new_from_string(<<"MATRIX");
[ 1  0  0  $translate_point->{x} ] 
[ 0  1  0  $translate_point->{y} ] 
[ 0  0  1  $translate_point->{z} ] 
[ 0  0  0  1 ]
MATRIX

	# backup m and apply transform to ourself
	$self->backup();
	$self->{m} = $transform->{m} * $self->{m_bak};

    return;
}


sub scale
{
    { my void::method $RETURN_TYPE };
    ( my object $self, my MathPerl::Geometry::Point3D $scale_factors) = @ARG;

	my $transform = MathPerl::Geometry::AffineTransformation3D->new();

	$transform->{m} = Math::MatrixReal->new_from_string(<<"MATRIX");
[ $scale_factors->{x}  0  0  0 ]
[ 0  $scale_factors->{y}  0  0 ]
[ 0  0  $scale_factors->{z}  0 ]
[ 0  0  0  1 ]
MATRIX

	# backup m and apply transform to ourself
	$self->backup();
	$self->{m} = $transform->{m} * $self->{m_bak};

    return;
}


# UPGRADE HERE: complete rotate() and shear()
# UPGRADE HERE: complete rotate() and shear()
# UPGRADE HERE: complete rotate() and shear()

#sub rotate
#{
#    { my integer::method $RETURN_TYPE };
#    ( my object $self) = @ARG;
#}


#sub shear
#{
#    { my integer::method $RETURN_TYPE };
#    ( my object $self) = @ARG;
#}


sub invert
{
    { my integer::method $RETURN_TYPE };
    ( my object $self) = @ARG;
    
    my integer $return_value;

	my $inverse_matrix;
	my $LR_matrix = $self->m->decompose_LR();

	if ($inverse_matrix = $LR_matrix->invert_LR())
	{
print {*STDERR} "in AffineTransformation3D->invert(), \$inverse_matrix = \n$inverse_matrix\n";
print {*STDERR} "in AffineTransformation3D->invert(), \$self->{m} * \$inverse_matrix = \n" . ($self->{m} * $inverse_matrix) . "\n";

		$self->{m_inverse} = $inverse_matrix;
		$return_value = 1;
	}
	else
	{
print {*STDERR} "in AffineTransformation3D->invert(), no inverse of \$self->{m} = \n$self->{m}";

		$self->{m_inverse} = undef;
		$return_value = -1;
	}

    return $return_value;
}


sub backup
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	# backup values
	$self->{m_bak} = $self->m->clone();

    return;
}


sub restore
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	# make temp copy of current values
	my $tmp = $self->m->clone();

	# restore backed up values
	$self->{m} = $self->m_bak->clone();

	# backup now old value
	$self->{m_bak} = $tmp;

    return;
}

1;    # end of class
