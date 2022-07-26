#!/usr/bin/perl

use strict;
use warnings;
use JSON::PP;
use List::Util qw(first);

my $string = `swaymsg -t get_inputs`;
my $inputs = decode_json $string;

my %next = (
    'Turkish'      => [ 'turkish (f)',  'tr(f)' ],
    'Turkish (F)'  => [ 'english (us)', 'us' ],
    'English (US)' => [ 'turkish',      'tr' ],
);

my $input   = first { defined $_->{xkb_active_layout_name} } @{$inputs};
my $current = $input->{xkb_active_layout_name};

system qw(notify-send -i settings -t 4000), "keyboard layout: $next{$current}[0]";
exec qw(swaymsg input type:keyboard xkb_layout), $next{$current}[1];
