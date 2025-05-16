#!/usr/bin/env perl

use v5.26; # signatures

use Test2::V0 -no_srand => 1;

BEGIN { eval qq(use lib "../lib") if $ENV{INSIDE_EMACS} }

use Mock::rand period => 2, target => 'Foo';

todo unimplemented => sub { pass };

done_testing; say 'done_testing';
