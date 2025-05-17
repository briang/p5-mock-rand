#!/usr/bin/env perl

use v5.26; # signatures

use Test2::V0 -no_srand => 1;

BEGIN { eval qq(use lib "../lib") if $ENV{INSIDE_EMACS} }

use Mock::rand;

todo unimplemented => sub { pass };

# what does rand(10) return?
# check the code!
# check the sort!

done_testing; say 'done_testing';
