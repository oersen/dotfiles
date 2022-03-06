#!/usr/bin/perl

use strict;
use warnings;
use JSON::PP;
use List::Util qw(first);

my $string = `swaymsg -t get_inputs`;
my $inputs = decode_json $string;

my %layouts = (
    'Turkish'      => 'tr(f)',
    'Turkish (F)'  => 'us',
    'English (US)' => 'tr',
);

my $input   = first { defined $_->{xkb_active_layout_name} } @{$inputs};
my $current = $input->{xkb_active_layout_name};
my $next    = $layouts{$current};

exec qw(swaymsg input type:keyboard xkb_layout), $next;
