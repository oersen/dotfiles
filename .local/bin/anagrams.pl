#!/usr/bin/perl

use strict;
use warnings;

my ( $key, @words, %anagrams );

while (<>) {
    @words = split /[\s_]+/, lc =~ s/[\W]+/ /gr;

    next unless @words;

    for my $word (@words) {
        $key = join "", sort split //, $word;

        $anagrams{$key}{$word}++;
    }
}

for my $key ( keys %anagrams ) {
    @words = sort keys %{ $anagrams{$key} };

    print "@words\n" if @words > 1;
}
