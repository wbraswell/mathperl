# [[[ HEADER ]]]
package MathPerl::GeometricAlgebra;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.000_003;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl);
use MathPerl;

# [[[ INCLUDES ]]]
use MathPerl::GeometricAlgebra::Products;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
