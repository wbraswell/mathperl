#!/usr/bin/env perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.000_021;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

# [[[ INCLUDES ]]]
use MathPerl::GeometricAlgebra;

# [[[ OPERATIONS ]]]

# variable declarations
my number $retval_number;
my number_arrayref $input_vector_1;
my number_arrayref $input_vector_2;

# 0
#$input_vector_1 = [-999999, 0.0, 0.0, 0.0];
#$input_vector_2 = [-999999, 3.0, 4.0, 12.0];

# 84
#$input_vector_1 = [-999999, 2.0, 4.0, 6.0];
#$input_vector_2 = [-999999, 3.0, 6.0, 9.0];

# 96
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 4.0, 12.0, 3.0];

# 96
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 12.0, 3.0, 4.0];

# 88
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 12.0, 4.0, 3.0];

# 168
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 4.0, 3.0, 12.0];

# 105
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 12.0, 4.0];

# 151
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, -3.0, 4.0, 12.0];

# 137
$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
$input_vector_2 = [-999999, 3.0, -4.0, 12.0];

# -119
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# ERROR: Argument vector 1 is not of magnitude 4
#$input_vector_1 = [-999999, 3.0, 4.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# ERROR: Argument vector 1 is not of magnitude 4
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0, 0.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# ERROR: Argument vector 2 is not of magnitude 4
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0];

# ERROR: Argument vector 2 is not of magnitude 4
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0, 0.0];

# ERROR ENVAVRV03, TYPE-CHECKING MISMATCH
# number_arrayref element value expected but non-number value found at index 0
#$input_vector_1 = ['howdy', 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# ERROR ENVAVRV03, TYPE-CHECKING MISMATCH
# number_arrayref element value expected but non-number value found at index 1
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 'howdy', 4.0, -12.0];

# ERROR ENVAVRV03, TYPE-CHECKING MISMATCH
# number_arrayref element value expected but non-number value found at index 2
#$input_vector_1 = [-999999, 3.0, 'howdy', 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# ERROR ENVAVRV03, TYPE-CHECKING MISMATCH
# number_arrayref element value expected but non-number value found at index 3
#$input_vector_1 = [-999999, 3.0, 4.0, 'howdy'];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# loop to test for memory leaks
my integer $i_MAX = 0;  # CONSTANT
for my integer $i ( 0 .. $i_MAX ) {
	print "in geometric_algebra_test_1_ipvve.pl, top of for() loop $i/$i_MAX\n";

    $retval_number = MathPerl::GeometricAlgebra::Products::inner_product__vector_vector_euclidean($input_vector_1, $input_vector_2);

    print "in geometric_algebra_test_1_ipvve.pl $i/$i_MAX, have \$retval_number =\n$retval_number\n";

#croak('Done for now, croaking');
}

#croak('Done for now, croaking');
