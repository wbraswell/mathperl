## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

package MathPerl::Config;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm

# DEV NOTE: this package exists to serve as the header file for MathPerl.pm itself




package MathPerl;

use RPerl::Config;

my $target_file_name_config = 'MathPerl/Config.pm';  # this file name
my $target_package_name_config = 'MathPerl::Config';  # this package name
my $target_file_name_pm = 'MathPerl.pm';
my $target_file_name_script = 'mathperl';



# [[[ OPERATIONS SPECIAL ]]]

# [ AUTOMATICALLY SET SYSTEM-DEPENDENT PATH VARIABLES ]
our $BASE_PATH    = undef;
our $INCLUDE_PATH = undef;    # all target system modules live here
our $SCRIPT_PATH  = undef;    # interpreted target system programs live here

if (   ( not exists $INC{$target_file_name_config} )
    or ( not defined $INC{$target_file_name_config} ) )
{
    Carp::croak 'BIZARRE ERROR EINPL00: Non-existent or undefined Perl %INC path entry for ' . $target_file_name_config . ', reported from within ' . $target_package_name_config . ', croaking';
}
my $target_config_pm_loaded = $INC{$target_file_name_config};
if ( not -e $target_config_pm_loaded ) {
    Carp::croak 'BIZARRE ERROR EINPL01: Non-existent file ',
        $target_config_pm_loaded,
        ' supposedly loaded in %INC, reported from within ' . $target_package_name_config . ', croaking';
}
( my $volume_loaded, my $directories_loaded, my $file_loaded ) = File::Spec->splitpath( $target_config_pm_loaded, my $no_file = 0 );
my @directories_loaded_split = File::Spec->splitdir($directories_loaded);

#print {*STDERR} 'in ' . $target_package_name_config . ', have pre-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";

# pop twice if empty entry on top
if ( pop @directories_loaded_split eq q{} ) { pop @directories_loaded_split; }
my $target_pm_wanted = File::Spec->catpath( $volume_loaded, ( File::Spec->catdir(@directories_loaded_split) ), $target_file_name_pm );

#print {*STDERR} 'in ' . $target_package_name_config . ', have post-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_config_pm_loaded = ', $target_config_pm_loaded, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_wanted = ', $target_pm_wanted, "\n";

my $target_pm_loaded = undef;
if ( ( exists $INC{$target_file_name_pm} ) and ( defined $INC{$target_file_name_pm} ) ) {
    $target_pm_loaded = $INC{$target_file_name_pm};

    # BULK88 20150608 2015.159: Win32 Bug Fix
    #    if ( not -e $target_pm_loaded ) {
    if ( not -f $target_pm_loaded ) {
        Carp::croak 'BIZARRE ERROR EINPL02: Non-existent file ', $target_pm_loaded, ' supposedly loaded in %INC, reported from within ' . $target_package_name_config . ', croaking';
    }
}

# strip trailing '/'
if ( ( substr $directories_loaded, -1, 1 ) eq q{/} ) {
    $directories_loaded = substr $directories_loaded, 0, -1;
}

#print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_loaded = ', $directories_loaded, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_loaded = ', ( $target_pm_loaded or '<undef>' ), "\n";

my $target_scripts_found    = [];
my $target_pms_found = [];

# BULK88 20150608 2015.159: Win32 Bug Fix
#foreach my $inc_path ( $directories_loaded, @INC ) {  # this doesn't work with Win32
# DEV NOTE: search order precedence for script command is OS paths, path of loaded TARGET/Config.pm (this file), Perl INC paths
foreach my $inc_path ( (split ':', $ENV{PATH}), File::Spec->catpath( $volume_loaded, $directories_loaded, '' ), @INC ) {

    #    print {*STDERR} 'in ' . $target_package_name_config . ', top of main foreach() loop, have $inc_path = ', $inc_path, "\n";
    my $sub_inc_paths = [];

    #    push @{$sub_inc_paths}, $inc_path;
    ( my $inc_volume, my $inc_directories, my $inc_file ) = File::Spec->splitpath( $inc_path, my $no_file = 1 );

    push @{$sub_inc_paths}, $inc_directories;

    my @directories_split = File::Spec->splitdir($inc_directories);
    pop @directories_split;
    push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);
    pop @directories_split;
    push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);

    #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $sub_inc_paths = ', "\n", Dumper($sub_inc_paths), "\n";
    #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_volume = ', "\n", Dumper($inc_volume), "\n";
    #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_directories = ', "\n", Dumper($inc_directories), "\n";
    #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_file = ', "\n", Dumper($inc_file), "\n";

    my $possible_target_scripts = [];
    foreach my $sub_inc_path ( @{$sub_inc_paths} ) {
        push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, $sub_inc_path, $target_file_name_script );
        if ( $sub_inc_path ne q{} ) {
            push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, File::Spec->catdir( $sub_inc_path, 'script' ), $target_file_name_script );
            push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, File::Spec->catdir( $sub_inc_path, 'bin' ),    $target_file_name_script );
        }
        else {
            push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, 'script', $target_file_name_script );
            push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, 'bin',    $target_file_name_script );
        }
    }

    foreach my $possible_target_script ( @{$possible_target_scripts} ) {

        #        print {*STDERR} 'in ' . $target_package_name_config . ', have $possible_target_script = ', $possible_target_script, "\n";
        # BULK88 20150608 2015.159: Win32 Bug Fix
        #        if ( ( -e $possible_target_script ) and ( -x $possible_target_script ) ) {
        if ( ( -f $possible_target_script ) and ( $OSNAME eq 'MSWin32' ? 1 : -x $possible_target_script ) ) {
            my $is_unique = 1;
            foreach my $target_script_found ( @{$target_scripts_found} ) {
                if ( $target_script_found eq $possible_target_script ) { $is_unique = 0; }
            }
            if ($is_unique) { push @{$target_scripts_found}, $possible_target_script; }
        }
    }

    if ( not defined $target_pm_loaded ) {
        my $possible_target_pm = File::Spec->catfile($inc_path, $target_file_name_pm);

        # BULK88 20150608 2015.159: Win32 Bug Fix
        #        if ( -e $possible_target_pm ) {
        if ( -f $possible_target_pm ) {
            my $is_unique = 1;
            foreach my $target_pm_found ( @{$target_pms_found} ) {
                if ( $target_pm_found eq $possible_target_pm ) {
                    $is_unique = 0;
                }
            }
            if ($is_unique) { push @{$target_pms_found}, $possible_target_pm; }
        }
    }
}

#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_scripts_found = ', "\n", Dumper($target_scripts_found), "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pms_found = ', "\n", Dumper($target_pms_found), "\n";

if ( scalar @{$target_scripts_found} == 0 ) {
    die 'ERROR EEXRP00: Failed to find `' . $target_file_name_script . '` executable, dying' . "\n";
}
my $target_script_found = $target_scripts_found->[0];
if ( scalar @{$target_scripts_found} > 1 ) {
    RPerl::warning( 'WARNING WEXRP00: Found multiple `' . $target_file_name_script . '` executables, using first located, ' . q{`} . $target_script_found . q{`} . "\n" );
}

my $target_pm_found = undef;
if ( defined $target_pm_loaded ) {
    $target_pm_found = $target_pm_loaded;
}
else {

    if ( scalar @{$target_pms_found} == 0 ) {
        Carp::croak 'ERROR EINRP00: Failed to find ' . $target_file_name_pm . ' module, croaking';
    }
    foreach my $target_pm_found_single ( @{$target_pms_found} ) {
        if ( $target_pm_found_single eq $target_pm_wanted ) {
            $target_pm_found = $target_pm_found_single;
        }
    }
    if ( not defined $target_pm_found ) {
        Carp::croak 'ERROR EINRP01: Expected to find ', $target_pm_wanted, ' but instead found ', "\n", Dumper($target_pms_found), ', croaking';
    }
}

#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_found = ', $target_pm_found, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $target_script_found = ', $target_script_found, "\n";

#( my $volume_target_pm, my $directories_target_pm, my $file_target_pm ) = File::Spec->splitpath( $target_pm_found, $no_file = 0 );
#( my $volume_target_script, my $directories_target_script, my $file_target_script ) = File::Spec->splitpath( $target_script_found, $no_file = 0 );
( undef, my $directories_target_pm, my $file_target_pm ) = File::Spec->splitpath( $target_pm_found, $no_file = 0 );
( undef, my $directories_target_script,    my $file_target_script )    = File::Spec->splitpath( $target_script_found,    $no_file = 0 );

#print {*STDERR} 'in ' . $target_package_name_config . ', have $volume_target_pm = ', $volume_target_pm, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_target_pm = ', $directories_target_pm, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $file_target_pm = ', $file_target_pm, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $volume_target_script = ', $volume_target_script, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_target_script = ', $directories_target_script, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $file_target_script = ', $file_target_script, "\n";

my @directories_target_pm_split = File::Spec->splitdir($directories_target_pm);
my @directories_target_script_split    = File::Spec->splitdir($directories_target_script);
my @directories_base_split     = ();

for my $i ( 0 .. ( ( scalar @directories_target_pm_split ) - 1 ) ) {
    if ( $directories_target_pm_split[$i] eq $directories_target_script_split[$i] ) {
        push @directories_base_split, $directories_target_pm_split[$i];
    }
    else {
        for my $j ( 0 .. ( $i - 1 ) ) {
            shift @directories_target_pm_split;
            shift @directories_target_script_split;
        }
        last;
    }
}

#print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_base_split = ', "\n", Dumper(\@directories_base_split), "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_target_pm_split = ', "\n", Dumper(\@directories_target_pm_split), "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_target_script_split = ', "\n", Dumper(\@directories_target_script_split), "\n";

# NEED FIX: how do we catpath() with some $volume instead of catdir() below, without breaking relative paths?
$BASE_PATH = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_base_split), '' );
if ( $BASE_PATH eq q{} ) {
    $INCLUDE_PATH = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_target_pm_split), '' );
    $SCRIPT_PATH  = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_target_script_split),    '' );

    #    print {*STDERR} 'in ' . $target_package_name_config . ', have $BASE_PATH eq q{} = ', $BASE_PATH, "\n";
}
else {
    $INCLUDE_PATH = File::Spec->catdir( $BASE_PATH, @directories_target_pm_split );
    $SCRIPT_PATH  = File::Spec->catdir( $BASE_PATH, @directories_target_script_split );

    #    print {*STDERR} 'in ' . $target_package_name_config . ', have $BASE_PATH ne q{} ', $BASE_PATH, "\n";
}

#print {*STDERR} 'in ' . $target_package_name_config . ', have $BASE_PATH = ', $BASE_PATH, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $INCLUDE_PATH = ', $INCLUDE_PATH, "\n";
#print {*STDERR} 'in ' . $target_package_name_config . ', have $SCRIPT_PATH = ', $SCRIPT_PATH, "\n";

1;    # end of package
