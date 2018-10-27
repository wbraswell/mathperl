# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector3D;
#package MathPerl::DataStructure::NumberVector3DFree;  # DEV NOTE: Vector3D is really NumberVector3DFree; shortened for convenience; contrasted with Vector3DBound which is really NumberVector3DBound
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector);
use MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    x => my number $TYPED_x = 0,
    y => my number $TYPED_y = 0,
    z => my number $TYPED_z = 0

    # DEV NOTE: x, y, and z are really head_x, head_y, and head_z; shortened for convenience
#    head_x => my number $TYPED_head_x = 0,
#    head_y => my number $TYPED_head_y = 0,
#    head_z => my number $TYPED_head_z = 0
};

1;    # end of class


# [[[ ADDITIONAL CLASSES ]]]

# [[[ HEADER ]]]
use RPerl;
package  # hide from PAUSE indexing
    Vector3D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector3D);
require MathPerl::DataStructure::Vector3D;

# [[[ OO PROPERTIES ]]]
our hashref $properties = $MathPerl::DataStructure::Vector3D::properties;

1;    # end of class