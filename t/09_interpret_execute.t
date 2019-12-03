#!/usr/bin/env perl  ## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_100;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code

# [[[ INCLUDES ]]]
use MathPerl;
use RPerl::Parser;
use RPerl::Generator;
use RPerl::Compiler;
use Test::More;
use Test::Exception;
use File::Find qw(find);
#use IPC::Open3;
#use IO::Select;
use IPC::Run3 qw(run3);
use Cwd;
use File::Spec;

# [[[ CONSTANTS ]]]
use constant PATH_TESTS => my string $TYPED_PATH_TESTS = $MathPerl::INCLUDE_PATH . '/MathPerl/Test';

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag("[[[ Beginning Interpret-Execute Pre-Test Loading, RPerl Execution System ]]]");
    }
    # DEV NOTE: can't do use_ok() or require_ok() because it will place them before all other BEGIN blocks,
    # which means we wil have 4 tests passing before we call 'plan tests',
    # which means we will fail to have 'plan tests' first OR done_testing() last, which causes a TAP failure;
    # must be included w/ regular 'use' operators above
#    lives_and( sub { require_ok('RPerl::AfterSubclass'); },            q{require_ok('RPerl::AfterSubclass') lives} );
#    lives_and( sub { require_ok('RPerl::Parser'); }, q{require_ok('RPerl::Parser') lives} );
#    lives_and( sub { require_ok('RPerl::Generator'); }, q{require_ok('RPerl::Generator') lives} );
#    lives_and( sub { require_ok('RPerl::Compiler'); }, q{require_ok('RPerl::Compiler') lives} );
}

# DEV NOTE: must specify number of tests in EITHER 'plan tests' or done_testing() below, not both
#my integer $number_of_tests_run = 4;  # initialize to 4 for use_ok() calls in BEGIN block above

my $test_files = {};    # string_hashref

# NEED UPDATE: use 'no_chdir => 1' like 13_generate.t
# save current directory for file checks, because File::Find changes directory;
# use File::Spec for MS Windows support, etc.
my $current_working_directory = getcwd;
(my $volume, my $directories, my $dummy_file) = File::Spec->splitpath( $current_working_directory, 1 );  # no_file = 1

find(
    sub {
        my $file = $File::Find::name;
#        RPerl::diag('in 09_interpret_execute.t, have $file = ' . $file . "\n");

        if (defined $ARGV[0]) {
            # restore saved path, because File::Find changes directories while searching for files
            my $file_full_path = File::Spec->catpath( $volume, $directories, $file );
#            RPerl::diag('in 09_interpret_execute.t, have $file_full_path = ' . $file_full_path . "\n");
            $file = $file_full_path;
        }

        #        if ( $file !~ m/.*OperatorVoid01NamedVoid.*[.]p[ml]$/xms ) { # TEMP DEBUGGING, ONLY FIND OperatorVoid01NamedVoid*/*.pm & *.pl
        if ( $file !~ m/.pl$/xms ) {
            return;
        }
        elsif ( ( $file =~ m/NotGood/ms ) or ( $file =~ m/not_good/ms ) ) {
            preprocess_execute_error($test_files, $file);
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) or ( $file =~ m/NotBad/ms ) or ( $file =~ m/not_bad/ms ) ) {
            open my filehandleref $FILE_HANDLE, '<', $file
                or croak 'ERROR, Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
            while (<$FILE_HANDLE>) {
                if (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes} }, $1;
                }
                elsif (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS_REGEX\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes} }, ('[IS_REGEX]' . $1);
                    RPerl::diag( 'in 09_interpret_execute.t, EXECUTE_SUCCESS_REGEX, have pattern = ', $1, "\n" );
                    RPerl::diag( 'in 09_interpret_execute.t, EXECUTE_SUCCESS_REGEX, have $test_files->{$file} = ', Dumper($test_files->{$file}), "\n" );
                }
                elsif (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS_INTEGER_32\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes_integer_32} }, $1;
                }
                elsif (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS_INTEGER_64\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes_integer_64} }, $1;
                }
                elsif (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS_NUMBER_32\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes_number_32} }, $1;
                }
                elsif (m/^\#\s*\<\<\<\s*EXECUTE_SUCCESS_NUMBER_64\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{successes_number_64} }, $1;
                }
#                else { RPerl::diag( 'in 09_interpret_execute.t, have unrecognized input file line = ', $_, "\n" ); }
                
                if (m/^\#\s*\<\<\<\s*EXECUTE\s*\:\s*OFF\s*\>\>\>/xms) {
                    delete $test_files->{$file};
                    last;
                }
            }
            close $FILE_HANDLE
                or croak 'ERROR, Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {
            preprocess_execute_error($test_files, $file);
        }
        else {
            return;
        }
    },
    (defined $ARGV[0]) ? $ARGV[0] : PATH_TESTS()
);

# trim unnecessary (and possibly problematic) absolute paths from input file names
# must be done outside find() to properly utilize getcwd()
foreach my string $test_file_key (sort keys %{$test_files}) {
    my string $test_file_key_trimmed = RPerl::Compiler::post_processor__absolute_path_delete($test_file_key);
    if ($test_file_key_trimmed ne $test_file_key) {
        $test_files->{$test_file_key_trimmed} = $test_files->{$test_file_key};
        delete $test_files->{$test_file_key};
    }
}

my integer $number_of_test_files = scalar keys %{$test_files};

#RPerl::diag( 'in 09_interpret_execute.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );
#RPerl::diag( 'in 09_interpret_execute.t, have sort keys %{$test_files} = ' . "\n" . Dumper(sort keys %{$test_files}) . "\n" );
#RPerl::diag( 'in 09_interpret_execute.t, have $number_of_test_files = ' . $number_of_test_files . "\n" );

plan tests => $number_of_test_files;

if ( $ENV{RPERL_VERBOSE} ) {
    Test::More::diag( '[[[ Beginning Interpret-Execute Tests, RPerl Execution System, PERL Operations & PERL Data Types' . ' ]]]' );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

my integer $i = 0;

# NEED ANSWER: keep IPC::Run3 code, or revert back to original IPC::Open3 code???
foreach my $test_file ( sort keys %{$test_files} ) {
    $i++;
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( 'Test File #' . $i . ' of ' . $number_of_test_files . ': ' . $test_file );
    }

#    RPerl::diag( 'in 09_interpret_execute.t, have $test_file = ' . $test_file . "\n" );
    #my $pid;
    my $stdout_generated = q{};
    my $stderr_generated = q{};
    if ( $RPerl::INCLUDE_PATH =~ /blib/ ) {
	    #$pid = open3( 0, \*STDOUT_TEST, \*STDERR_TEST, $test_file_execute_command );    # disable STDIN w/ 0
        my string $test_file_execute_command = $EXECUTABLE_NAME . ' -Mblib=' . $RPerl::INCLUDE_PATH . ' ' . $test_file;
#        RPerl::diag( 'in 09_interpret_execute.t, yes blib INCLUDE_PATH, have $test_file_execute_command = ' . $test_file_execute_command . "\n" );
#        RPerl::diag( 'in 09_interpret_execute.t, yes blib INCLUDE_PATH, about to call open3()...' . "\n" );
	run3( $test_file_execute_command, \undef, \$stdout_generated, \$stderr_generated );
	#$pid = open3( 0, \*STDOUT_TEST, \*STDERR_TEST, $test_file_execute_command );    # disable STDIN w/ 0
#        RPerl::diag( 'in 09_interpret_execute.t, yes blib INCLUDE_PATH, returned from open3(), have $pid = ' . $pid . "\n" );
    }
    else {
        my string $test_file_execute_command = $EXECUTABLE_NAME . ' -I' . $RPerl::INCLUDE_PATH . ' ' . $test_file;
#        RPerl::diag( 'in 09_interpret_execute.t, not blib INCLUDE_PATH, have $test_file_execute_command = ' . $test_file_execute_command . "\n" );
#        RPerl::diag( 'in 09_interpret_execute.t, not blib INCLUDE_PATH, about to call open3()...' . "\n" );
#         my $stdout_select;
#    my $stderr_select;
#    if ( $OSNAME ne 'MSWin32' ) {
##        RPerl::diag( 'in 09_interpret_execute.t, no MSWin32, about to call IO::Select->new()...' . "\n" );
#        $stdout_select = IO::Select->new();
#        $stderr_select = IO::Select->new();
##        RPerl::diag( 'in 09_interpret_execute.t, no MSWin32, about to call $stdout_select->add( \*STDOUT_TEST )...' . "\n" );
#        $stdout_select->add( \*STDOUT_TEST );
#        $stderr_select->add( \*STDERR_TEST );
##        RPerl::diag( 'in 09_interpret_execute.t, no MSWin32, returned from $stdout_select->add( \*STDOUT_TEST )' . "\n" );
#    }
#
#    my $stdout_generated = q{};
#    my $stderr_generated = q{};
#
	run3( $test_file_execute_command, \undef, \$stdout_generated, \$stderr_generated );
	#$pid = open3( 0, \*STDOUT_TEST, \*STDERR_TEST, $test_file_execute_command );    # disable STDIN w/ 0
#        RPerl::diag( 'in 09_interpret_execute.t, not blib INCLUDE_PATH, returned from open3(), have $pid = ' . $pid . "\n" );
    }

    # DISABLED: no user input accepted
    #    while (1) {
    #        print "Enter input\n";
    #        chomp( my $stdin_received = <STDIN_TEST> );
    #        print STDIN_TEST "$stdin_received\n";
   #    select( undef, undef, undef, 0.1 ); # allow time for output to be generated; not needed with waitpid() before sysread() calls below
#
#    #        if ( $stdout_select->can_read(0) )  { RPerl::diag('in 09_interpret_execute.t, can read STDOUT_TEST for $test_file = ' . $test_file . "\n"); }
#    #        if ( $stderr_select->can_read(0) )  { RPerl::diag('in 09_interpret_execute.t, can read STDERR_TEST for $test_file = ' . $test_file . "\n"); }
#
#    if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) {
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stdout_select->can_read(0), about to call sysread STDOUT_TEST...' . "\n" );
#        sysread STDOUT_TEST, $stdout_generated, 4096;
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stdout_select->can_read(0), returned from sysread STDOUT_TEST, have $stdout_generated = ' . "\n" . '[BEGIN STDOUT]' . "\n" . $stdout_generated . '[END STDOUT]' . "\n" );
#    }
#    if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) {
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stderr_select->can_read(0), about to call sysread STDERR_TEST...' . "\n" );
#        sysread STDERR_TEST, $stderr_generated, 4096;
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stderr_select->can_read(0), returned from sysread STDERR_TEST, have $stderr_generated = ' . "\n" . '[BEGIN STDERR]' . "\n" . $stderr_generated . '[END STDERR]' . "\n" );
#    }
#
##    RPerl::diag( 'in 09_interpret_execute.t, have $pid = ' . $pid . ', about to call waitpid...' . "\n" );
#    waitpid $pid, 0;
##    RPerl::diag( 'in 09_interpret_execute.t, have $pid = ' . $pid . ', returned from waitpid...' . "\n" );
#
#    if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) {
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stdout_select->can_read(0), about to call sysread STDOUT_TEST...' . "\n" );
#        my string $stdout_generated_continued;
#        sysread STDOUT_TEST, $stdout_generated_continued, 4096;
#        $stdout_generated .= $stdout_generated_continued;
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stdout_select->can_read(0), returned from sysread STDOUT_TEST, have $stdout_generated_continued = ' . "\n" . '[BEGIN STDOUT]' . "\n" . $stdout_generated_continued . '[END STDOUT]' . "\n" );
#    }
#    if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) {
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stderr_select->can_read(0), about to call sysread STDERR_TEST...' . "\n" );
#        my string $stderr_generated_continued;
#        sysread STDERR_TEST, $stderr_generated_continued, 4096;
#        $stderr_generated .= $stderr_generated_continued;
##        RPerl::diag( 'in 09_interpret_execute.t, yes MSWin32 or $stderr_select->can_read(0), returned from sysread STDERR_TEST, have $stderr_generated_continued = ' . "\n" . '[BEGIN STDERR]' . "\n" . $stderr_generated_continued . '[END STDERR]' . "\n" );
#    }
  

    # DISABLED: no user input accepted
    #        $stdout_generated = q{};
    #        $stderr_generated = q{};
    #    }

    my $test_exit_status = $CHILD_ERROR >> 8;

#    RPerl::diag( 'in 09_interpret_execute.t, have $CHILD_ERROR = ' . $CHILD_ERROR . "\n" );
#    RPerl::diag( 'in 09_interpret_execute.t, have $test_exit_status = ' . $test_exit_status . "\n" );

#    if ($stdout_generated) { RPerl::diag( "===STDOUT=BEGIN====\n" . $stdout_generated . "===STDOUT=END======\n" ); }
#    if ($stderr_generated) { RPerl::diag( "===STDERR=BEGIN====\n" . $stderr_generated . "===STDERR=END======\n" ); }

    my @stdout_generated_lines_array = split( "\n", $stdout_generated );
    my string_arrayref $stdout_generated_lines = \@stdout_generated_lines_array;

    if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
        if ( ( $test_file =~ m/NotGood/xms ) or ( $test_file =~ m/not_good/xms ) ) {
            ok( ( missing_errors_count($test_files, $test_file, $stdout_generated, $stderr_generated) == 0 ), 'Program interprets and executes with expected error(s):' . ( q{ } x 2 ) . $test_file );
#            $number_of_tests_run++;
        }
        elsif ( ( $test_file =~ m/Good/xms ) or ( $test_file =~ m/good/xms ) or ( $test_file =~ m/NotBad/xms ) or ( $test_file =~ m/not_bad/xms ) ) {
            my $missing_successes = [];
#            RPerl::diag( 'in 09_interpret_execute.t, run success on good code, have $test_files->{$test_file} = ' . Dumper($test_files->{$test_file}) . "\n\n" );

            if ( defined $test_files->{$test_file}->{successes} ) {
                success_match($test_file, $test_files->{$test_file}->{successes}, $stdout_generated_lines);
            }
            elsif ( ( defined $test_files->{$test_file}->{successes_integer_32} ) and ( rperltypessizes::type_integer_bitsize() == 32 ) ) {
                success_match($test_file, $test_files->{$test_file}->{successes_integer_32}, $stdout_generated_lines);
            }
            elsif ( ( defined $test_files->{$test_file}->{successes_integer_64} ) and ( rperltypessizes::type_integer_bitsize() == 64 ) ) {
                success_match($test_file, $test_files->{$test_file}->{successes_integer_64}, $stdout_generated_lines);
            }
            elsif ( ( defined $test_files->{$test_file}->{successes_number_32} ) and ( rperltypessizes::type_number_bitsize() == 32 ) ) {
                success_match($test_file, $test_files->{$test_file}->{successes_number_32}, $stdout_generated_lines);
            }
            elsif ( ( defined $test_files->{$test_file}->{successes_number_64} ) and ( rperltypessizes::type_number_bitsize() == 64 ) ) {
                success_match($test_file, $test_files->{$test_file}->{successes_number_64}, $stdout_generated_lines);
            }

            #DISABLE
            # NEED UPGRADE: below code allows success strings to be matched out-of-order in captured output
            # enable with some appropriate preprocessor keyword
            #                foreach my $success (
            #                    @{ $test_files->{$test_file}->{successes} } )
            #                {
            #                    if ( $stdout_generated !~ /\Q$success\E/xms ) {
            #                        push @{$missing_successes},
            #                            "Success message '$success' expected, but not found";
            #                    }
            #                }
            #            }
            #            RPerl::verbose( 'in 09_interpret_execute.t, have $missing_successes =' . "\n" . Dumper($missing_successes) . "\n" );
            #            ok( ( ( scalar @{$missing_successes} ) == 0 ), 'Program interprets and executes without errors:' . (q{ } x 10) . $test_file );

        }
        else {
            ok( 0, 'Program interprets and executes with errors:' . ( q{ } x 13 ) . $test_file );
#            $number_of_tests_run++;
        }
    }
    else {    # UNIX process return code not 0, error
        if ( ( $test_file =~ m/NotBad/ms ) or ( $test_file =~ m/not_bad/ms ) ) {
            ok( 0, 'Program interprets and executes without errors:' . ( q{ } x 10 ) . $test_file );
#            $number_of_tests_run++;
        }
        elsif ( ( $test_file =~ m/Bad/ms ) or ( $test_file =~ m/bad/ms ) or ( $test_file =~ m/NotGood/ms ) or ( $test_file =~ m/not_good/ms )  ) {
            ok( ( missing_errors_count($test_files, $test_file, $stdout_generated, $stderr_generated) == 0 ), 'Program interprets and executes with expected error(s):' . ( q{ } x 2 ) . $test_file );
#            $number_of_tests_run++;
        }
        else {
            ok( 0, 'Program interprets and executes without errors:' . ( q{ } x 10 ) . $test_file );
#            $number_of_tests_run++;
        }
    }
}

sub preprocess_execute_error {
    (my string_hashref $test_files, my string $file) = @ARG;
    open my filehandleref $FILE_HANDLE, '<', $file
        or croak 'ERROR, Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
    while (<$FILE_HANDLE>) {
        if (m/^\#\s*\<\<\<\s*EXECUTE\s*\:\s*OFF\s*\>\>\>/xms) {
            delete $test_files->{$file};
            last;
        }
        if (m/^\#\s*\<\<\<\s*EXECUTE_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
            push @{ $test_files->{$file}->{errors} }, $1;
        }
    }
    close $FILE_HANDLE
        or croak 'ERROR, Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';
}

sub missing_errors_count {
    (my string_hashref $test_files, my string $test_file, my string $stdout_generated, my string $stderr_generated) = @ARG;
    my $missing_errors = [];
    if ( defined $test_files->{$test_file}->{errors} ) {
        foreach my $error ( @{ $test_files->{$test_file}->{errors} } ) {
            if (    ( $stdout_generated !~ /\Q$error\E/xms )
                and ( $stderr_generated !~ /\Q$error\E/xms ) )
            {
                push @{$missing_errors}, "Error message '$error' expected, but not found";
            }
        }
    }
   return scalar @{$missing_errors};
}

sub success_match {
    (my string $test_file, my string_arrayref $test_file_successes, my string $stdout_generated_lines) = @ARG;
#    $RPerl::DEBUG   = 0;
#    $RPerl::VERBOSE = 0;

#    RPerl::diag( 'in 09_interpret_execute.t success_match(), before foreach loop, received $test_file_successes =', Dumper( $test_file_successes ) );

    my string $success = $test_file_successes->[0];

    # match success strings in-order in captured output
FOREACH_STDOUT_LINE: foreach my string $stdout_generated_line ( @{$stdout_generated_lines} ) {
        my boolean $is_regex = 0;
        if ((substr $success, 0, 10) eq '[IS_REGEX]') {
            substr $success, 0, 10, '';  # discard [IS_REGEX] prefix
            $is_regex = 1;
        }

#        RPerl::diag( 'in 09_interpret_execute.t success_match(), top of foreach loop, have $is_regex = ' . $is_regex . "\n" );
#        RPerl::diag( 'in 09_interpret_execute.t success_match(), top of foreach loop, have $success               = ' . $success . "\n" );
#        RPerl::diag( 'in 09_interpret_execute.t success_match(), top of foreach loop, have $stdout_generated_line = ' . $stdout_generated_line . "\n" );

        if ($is_regex) {
            # each stdout line is only allowed to match one success string
            if ( $stdout_generated_line =~ /$success/ms ) {  # omit quotemeta \Q and \E regex modifiers for regex strings to be matched, also omit /x modifier to correctly match spaces
#                RPerl::diag( 'in 09_interpret_execute.t success_match(), YES REGEX, MATCH' . "\n" );
                shift @{ $test_file_successes };
                if ( ( scalar @{ $test_file_successes } ) == 0 ) { last FOREACH_STDOUT_LINE; }
                $success = $test_file_successes->[0];
            }
#            else { RPerl::diag( 'in 09_interpret_execute.t success_match(), YES REGEX, NO MATCH' . "\n" ); }
        }
        else {
            # each stdout line is only allowed to match one success string
            if ( $stdout_generated_line =~ /\Q$success\E/xms ) {  # include quotemeta \Q and \E regex modifiers for normal literal strings to be matched
#                RPerl::diag( 'in 09_interpret_execute.t success_match(), no regex, MATCH' . "\n" );
                shift @{ $test_file_successes };
                if ( ( scalar @{ $test_file_successes } ) == 0 ) { last FOREACH_STDOUT_LINE; }
                $success = $test_file_successes->[0];
            }
#            else { RPerl::diag( 'in 09_interpret_execute.t success_match(), no regex, NO MATCH' . "\n" ); }
        }
    }
#    RPerl::diag( 'in 09_interpret_execute.t success_match(), have missing successes =' . "\n" . Dumper( $test_file_successes ) . "\n" );
    ok( ( ( scalar @{ $test_file_successes } ) == 0 ), 'Program interprets and executes without errors & with expected output:' . ( q{ } x 10 ) . $test_file );
#    $number_of_tests_run++;
}

#RPerl::diag( 'in 09_interpret_execute.t, have $number_of_tests_run =' . $number_of_tests_run . "\n" );

done_testing();
#done_testing($number_of_tests_run);
