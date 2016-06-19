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
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional & subclass & shorthand package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = { head => my number_arrayref $TYPED_head = [] };

# [[[ SUBROUTINES & OO METHODS ]]]

our MathPerl::DataStructure::Vector $test_constructor = sub {
    ( my integer $i ) = @_;
    my MathPerl::DataStructure::Vector $retval = MathPerl::DataStructure::Vector->new();
    $retval->{head}->[$i - 1] = undef;  # NEED RECOGNIZE AS resize()

    for (my integer $j = 0; $j < $i; $j++) {
        $retval->{head}->[$j] = $j * 5;
    }

    return $retval;
};

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


# [[[ ADDITIONAL CLASSES ]]]

# [[[ HEADER ]]]
use RPerl;
package  # hide from PAUSE indexing
    Vector;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MathPerl::DataStructure::Vector);
require MathPerl::DataStructure::Vector;

# [[[ OO PROPERTIES ]]]
our hashref $properties = $MathPerl::DataStructure::Vector::properties;

1;    # end of class