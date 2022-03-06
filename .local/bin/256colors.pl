#!/usr/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

for my $i ( 0 .. 255 ) {
    printf "%s%4d", color("ansi$i"), $i;

    print "\n" if $i % 8 == 7;
}

END {
    print color("reset");
}
