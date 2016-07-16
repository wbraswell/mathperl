#!/usr/bin/perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers

# [[[ OPERATIONS ]]]

my constant_integer $t_big = 5;
my constant_integer $n_big = 10;
my number_arrayref_arrayref $arr = number_arrayref_arrayref::new( $n_big, $n_big );

# initialize array
for ( my integer $i = 0; $i < $n_big; $i++ ) {
    for ( my integer $j = 0; $j < $n_big; $j++ ) {
        $arr->[$i]->[$j] = $i * $i + $j * $j;
    }
}

# calculate results
PARALLEL: for ( my integer $t = 0; $t <= $t_big - 1; $t++ ) {
    for ( my integer $i = 1; $i <= $n_big - 2; $i++ ) {
        for ( my integer $j = 1; $j <= $n_big - 2; $j++ ) {
            print 'Have  pre-modification $arr->[', $i, ']->[', $j, '] = ', $arr->[$i]->[$j], "\n";
            $arr->[$i]->[$j]
                = (   $arr->[ $i - 1 ]->[ $j - 1 ]
                    + $arr->[ $i - 1 ]->[$j]
                    + $arr->[ $i - 1 ]->[ $j + 1 ]
                    + $arr->[$i]->[ $j - 1 ]
                    + $arr->[$i]->[$j]
                    + $arr->[$i]->[ $j + 1 ]
                    + $arr->[ $i + 1 ]->[ $j - 1 ]
                    + $arr->[ $i + 1 ]->[$j]
                    + $arr->[ $i + 1 ]->[ $j + 1 ] ) / 9.0;
            print 'Have post-modification $arr->[', $i, ']->[', $j, '] = ', $arr->[$i]->[$j], "\n";
        }
    }
}

print 'Have final answer, final element $arr->[', ($n_big - 2), ']->[', ($n_big - 2), '] = ', $arr->[($n_big - 2)]->[($n_big - 2)], "\n";
