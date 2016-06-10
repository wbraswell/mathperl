#!/usr/bin/perl

# DEV NOTE: disable tests which may return different results based on floating-point accuracy of operating system, Perl, C compiler, etc.

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '1' >>>
# <<< EXECUTE_SUCCESS: '0' >>>
# <<< EXECUTE_SUCCESS: '0' >>>
# <<< EXECUTE_SUCCESS_DISABLE: '0' >>>
# <<< EXECUTE_SUCCESS_DISABLE: '0' >>>
# <<< EXECUTE_SUCCESS_DISABLE: '0' >>>
# <<< EXECUTE_SUCCESS_DISABLE: '0' >>>
# <<< EXECUTE_SUCCESS: '1' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use MathPerl::Arithmetic::ApproximatelyEqual;

# [[[ OPERATIONS ]]]
print approximately_equal(0, 0);
print "\n";
print approximately_equal(0, 0.1);
print "\n";
print approximately_equal(0, 0.001);
print "\n";
#print approximately_equal(0, 0.000_001);
#print "\n";
#print approximately_equal(0, 0.000_000_001);
#print "\n";
#print approximately_equal(0, 0.000_000_000_001);
#print "\n";
#print approximately_equal(0, 0.000_000_000_000_001);
#print "\n";
print approximately_equal(0, 0.000_000_000_000_000_001);
print "\n";
