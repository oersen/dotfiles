#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    print join "", map { rand() < 0.5 ? lc : uc } split //;
}
