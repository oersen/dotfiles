#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sample);

my $money  = 96;
my $rounds = 0;
my @names  = qw(2 3 4 5 6 7 8 9 10 Jack Queen King Ace);
my @suits  = qw(Hearts Diamonds Clubs Spades);
my ( @fullnames, @cards, @ranks );

while ( $money > 0 ) {
    $rounds++;
    @cards = sample 3, 0 .. 51;

    for my $i ( 0 .. 2 ) {
        $ranks[$i] = $cards[$i] % 13;
    }

    if ( $ranks[0] > $ranks[1] ) {
        ( $cards[0], $cards[1] ) = ( $cards[1], $cards[0] );
        ( $ranks[0], $ranks[1] ) = ( $ranks[1], $ranks[0] );
    }

    next if ( $ranks[1] - $ranks[0] < 2 );

    for my $i ( 0 .. 2 ) {
        $fullnames[$i] = "$names[ $ranks[$i] ] of $suits[ $cards[$i] / 13 ]";
    }

    print "\n[ROUND $rounds]\nDealt: '$fullnames[0]' & '$fullnames[1]'\n";

    my $bet = "";
    while ( $bet !~ /\A\d+\n?\z/ or $bet > $money ) {
        print "Amount of the bet (max $money): ";
        $bet = <STDIN> or die "Chicken!\n";
    }

    if ( $bet == 0 ) {
        print "Chicken!\n";
    }
    else {
        print "The third card: '$fullnames[2]'\n";

        if ( $ranks[2] > $ranks[0] and $ranks[2] < $ranks[1] ) {
            $money += $bet;
            print "Win! ";
        }
        else {
            $money -= $bet;
            print "Lost! ";
        }

        print "Cash: $money\n";
    }
}
