## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

package MathPerl::Config;
use strict;
use warnings;
our $VERSION = 0.002_000;
our $IS_RPERL_CONFIG = 1;  # DEV NOTE, CORRELATION #rp027: RPerl::Config, MathPerl::Config, PhysicsPerl::Config, etc

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# DEV NOTE: this package exists to serve as the header file for MathPerl.pm itself

package MathPerl;

# [[[ INCLUDES ]]]
use RPerl::Config;

# [[[ OO CLASS PROPERTIES SPECIAL ]]]
our $BASE_PATH    = undef;    # all target software lives below here
our $INCLUDE_PATH = undef;    # all target system modules live here
our $SCRIPT_PATH  = undef;    # interpreted target system programs live here

# [[[ OPERATIONS SPECIAL ]]]

# set system paths
my $file_name_config    = 'MathPerl/Config.pm';    # this file name
my $package_name_config = 'MathPerl::Config';      # this file's primary package name
my $file_name_pm        = 'MathPerl.pm';
my $file_name_script    = 'mathperl';
( $BASE_PATH, $INCLUDE_PATH, $SCRIPT_PATH ) = @{ RPerl::set_system_paths( $file_name_config, $package_name_config, $file_name_pm, $file_name_script ) };

1;                                                 # end of package


# export system paths to main:: namespace for use by PMC files
package main;

# [[[ OO CLASS PROPERTIES SPECIAL ]]]
# DEV NOTE: duplicate lines to avoid 'used only once' warnings
our $BASE_PATH = $MathPerl::BASE_PATH;
$BASE_PATH = $MathPerl::BASE_PATH;
our $INCLUDE_PATH = $MathPerl::INCLUDE_PATH;
$INCLUDE_PATH = $MathPerl::INCLUDE_PATH;
our $SCRIPT_PATH  = $MathPerl::SCRIPT_PATH;
$SCRIPT_PATH  = $MathPerl::SCRIPT_PATH;

1;                                                 # end of package
