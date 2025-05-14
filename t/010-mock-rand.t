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

pass;

done_testing;
