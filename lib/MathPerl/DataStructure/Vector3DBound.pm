# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector3DBound;
#package MathPerl::DataStructure::NumberVector3DBound;  # DEV NOTE: Vector3DBound is really NumberVector3DBound, contrasted with Vector3D which is really NumberVector3DFree
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector);
use MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    x0 => my number $TYPED_x0 = 0,
    y0 => my number $TYPED_y0 = 0,
    z0 => my number $TYPED_z0 = 0,

    x => my number $TYPED_x = 0,
    y => my number $TYPED_y = 0,
    z => my number $TYPED_z = 0
};

1;    # end of class
