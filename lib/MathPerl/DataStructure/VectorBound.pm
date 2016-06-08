# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::VectorBound;
#package MathPerl::DataStructure::NumberVectorBound;  # DEV NOTE: VectorBound is really NumberVectorBound; shortened for convenience; contrasted with Vector which is really NumberVectorFree
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure);
use MathPerl::DataStructure;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    tail => my number_arrayref $TYPED_tail = [],
    head => my number_arrayref $TYPED_head = []
};

1;    # end of class
