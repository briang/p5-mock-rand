#!/usr/bin/env perl

use v5.20;

BEGIN { eval qq(use lib "../lib") if $ENV{INSIDE_EMACS} }

use Test2::V0 -no_srand => 1;

use Mock::rand period => 4;

rand();
is rand(), 0.25, 'rand() is 1/4';

Mock::rand->import(period => 8);

rand();
is rand(), 0.125, 'rand() is 1/8';

done_testing; say 'done_testing';
