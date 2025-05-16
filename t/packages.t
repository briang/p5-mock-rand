#!/usr/bin/env perl

use v5.26; # signatures

use Test2::V0 -no_srand => 1;

BEGIN { eval qq(use lib "../lib") if $ENV{INSIDE_EMACS} }

use Mock::rand period => 2, target => 'Foo';

ok length      rand() > 8, "using CORE::rand";
ok length Foo::rand() < 8, "using Mock::rand";

done_testing; say 'done_testing';
