#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sample);

my $count = shift || 6;
my $limit = shift || 9;
my @nums  = sample $count, 1 .. $limit;

print "@nums\n";
