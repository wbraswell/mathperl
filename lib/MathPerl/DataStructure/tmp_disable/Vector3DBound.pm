# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector3DBound;
#package MathPerl::DataStructure::NumberVector3DBound;  # DEV NOTE: Vector3DBound is really NumberVector3DBound; shortened for convenience; contrasted with Vector3D which is really NumberVector3DFree
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector);
use MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    tail_x => my number $TYPED_tail_x = 0,
    tail_y => my number $TYPED_tail_y = 0,
    tail_z => my number $TYPED_tail_z = 0,

    head_x => my number $TYPED_head_x = 0,
    head_y => my number $TYPED_head_y = 0,
    head_z => my number $TYPED_head_z = 0
};

1;    # end of class
