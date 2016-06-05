# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector3D;
#package MathPerl::DataStructure::NumberVector3DFree;  # DEV NOTE: Vector3D is really NumberVector3DFree, contrasted with Vector3DBound which is really NumberVector3DBound
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector);
use MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    x => my number $TYPED_x = 0,
    y => my number $TYPED_y = 0,
    z => my number $TYPED_z = 0
};

1;    # end of class
