# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure);
use MathPerl::DataStructure;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    data => my number_arrayref $TYPED_data = []
};

1;    # end of class
