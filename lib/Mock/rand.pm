use v5.20;

package Mock::rand;

=NAME

Mock::rand - controllable random numbers for testing purposes

=VERSION

0.010
released on
2025-03-31

=SYNOPSIS

use Mock::rand { period => 4 };

say rand; # 0
say rand; # 0.25
say rand; # 0.5
say rand; # 0.75
say rand; # 0

=cut

our $VERSION = '0.010';

use Carp 'croak';

use constant {
    ORDERED   => 'ordered',
    UNORDERED => 'unordered',
};

my $period = 1024;
my $seed;
my @rands;

sub import {
    croak 'List of key-value pairs expected' unless @_ & 1;
    my ($package, %opts) = @_;

    my $target;
    my $type = ORDERED;

    for my $k ( keys %opts ) {
        my $v = $opts{$k};

        if    ($k eq 'target') { $target = $v }
        elsif ($k eq 'period') { $period = $v }
        elsif ($k eq 'type') {
            croak sprintf q("type" must be "%s" or "%s"), ORDERED, UNORDERED
                unless $v eq ORDERED or $v eq UNORDERED;
            $type = $v;
        }
        else { croak qq(unknown key "$k") }
    }

    $target = caller unless defined $target;

    {   no strict "refs";
        *{"${target}::rand"} =
            ($type eq 'ordered' ? *ordered_rand : *unordered_rand)   }
    $seed = 0;
    @rands = ();
}

sub ordered_rand :prototype(;$) {
    $seed %= $period;
    return $seed++ / $period * ($_[0] || 1);
};

sub unordered_rand :prototype(;$) {
    if (@rands == 0) {
        @rands =
            sort { rand() <=> 0.5 } # shuffle!
            map  { &ordered_rand } 1 .. $period;
    }
    return pop @rands;
}

1;
