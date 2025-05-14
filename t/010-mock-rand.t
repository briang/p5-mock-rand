#!/usr/bin/env perl

use v5.26; # signatures

use Test2::V0 -no_srand => 1;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Data::Dump; # FIXME

# { no warnings 'redefine'; sub Test2::API::test2_stdout { open my $f, '>', '/dev/null'; $f } }
################################################################################
use Mock::rand +{
    target => 'Random::Picker',
    period => 1024,
    type   => 'ordered',
};

use Random::Picker;

subtest equal_weights => sub {
    my $rp = Random::Picker->new;
    my @keys = qw'A B C D';
    $rp->add($_) for @keys;

    my %h;
    $h{$rp->pick}++ for 1..1024;

    for (@keys) {
        is $h{$_}, 256, "$_ chosen 256 times";
    }
};

subtest default_weights => sub {
    my $rp = Random::Picker->new;
    $rp->add('A');
    $rp->add('B', 3);

    my %h;
    $h{$rp->pick}++ for 1..1024;

    is $h{A}, 256, "A chosen 256 times";
    is $h{B}, 768, "B chosen 768 times";
};

subtest different_weights => sub {
    my $rp = Random::Picker->new;
    $rp->add('A', 1);
    $rp->add('B', 2);
    $rp->add('C', 0.5);
    $rp->add('D', 0.5);

    my %h;
    $h{$rp->pick}++ for 1..1024;

    is $h{A}, 256, "A chosen 256 times";
    is $h{B}, 512, "B chosen 512 times";
    is $h{C}, 128, "C chosen 128 times";
    is $h{C}, 128, "D chosen 128 times";
};

done_testing;
