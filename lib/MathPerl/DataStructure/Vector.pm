# [[[ HEADER ]]]
use RPerl;
package MathPerl::DataStructure::Vector;
#package MathPerl::DataStructure::NumberVectorFree;  # DEV NOTE: Vector is really NumberVectorFree; shortened for convenience; contrasted with VectorBound which is really NumberVectorBound
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure);
use MathPerl::DataStructure;

# [[[ CRITICS ]]]
# # no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional & subclass & shorthand package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = { head => my number_arrayref $TYPED_head = [] };

# [[[ OO METHODS & SUBROUTINES ]]]

# [[[ STRINGIFY ]]]

our string::method $To_string = sub {
    ( my MathPerl::DataStructure::Vector $self ) = @_;
    return ::number_arrayref_to_string($self->{head});
};

our string $Vector_to_string = sub {
    ( my MathPerl::DataStructure::Vector $input_vector ) = @_;
    return ::number_arrayref_to_string($input_vector->{head});
};

1;    # end of class


# [[[ SHORTHAND CLASSES ]]]

# [[[ HEADER ]]]
#use RPerl;
#package  # hide from PAUSE indexing
#    Vector;
#use strict;
#use warnings;
#our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(MathPerl::DataStructure::Vector);
#require MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
#our hashref $properties = $MathPerl::DataStructure::Vector::properties;

#1;    # end of class