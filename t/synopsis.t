#!/usr/bin/env perl

use v5.26; # signatures

use Test2::V0 -no_srand => 1;

BEGIN { eval qq(use lib "../lib") if $ENV{INSIDE_EMACS} }

use Mock::rand period => 4;

is rand(), 0.00, "rand returns 0/4";
is rand(), 0.25, "rand returns 1/4";
is rand(), 0.50, "rand returns 2/4";
is rand(), 0.75, "rand returns 3/4";
is rand(), 0.00, "rand returns 0/4";

done_testing; say 'done_testing';
