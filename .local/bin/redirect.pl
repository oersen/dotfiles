#!/usr/bin/perl

use strict;
use warnings;

my $url = `wl-paste`;

$url =~ s{(?:https?://)?(?:.+\.)?(?:youtube\.com|youtu\.be)}{https://piped.kavin.rocks};
$url =~ s{(?:https?://)?(?:.+\.)?4chan(?:nel)?\.org}{https://desuarchive.org};
$url =~ s{(?:https?://)?(?:.+\.)?urbandictionary\.com}{https://rd.vern.cc};
$url =~ s{(?:https?://)?(?:.+\.)?wikipedia\.org}{https://wikiless.org};
$url =~ s{(?:https?://)?(?:.+\.)?github\.com}{https://gh.vern.cc};
$url =~ s{(?:https?://)?(?:.+\.)?stackoverflow\.com}{https://ao.vern.cc};
$url =~ s{(?:https?://)?(?:.+\.)?twitter\.com}{https://nitter.net};
$url =~ s{(?:https?://)?(?:.+\.)?reddit\.com}{https://teddit.net};
$url =~ s{(?:https?://)?(?:.+\.)?medium\.com}{https://scribe.rip};
$url =~ s{(?:https?://)?(?:.+\.)?imgur\.com}{https://rg.vern.cc};
$url =~ s{(?:https?://)?(?:.+\.)?goodreads\.com}{https://biblioreads.ml};
$url =~ s{(?:https?://)?(?:.+\.)?imdb\.com}{https://libremdb.iket.me};
$url =~ s{(?:https?://)?(?:.+\.)?quora\.com}{https://quetre.iket.me};
$url =~ s{(?:https?://)?([^.]+)?\.?fandom\.com}{https://breezewiki.com/$1};

exec qw(wl-copy -o), $url;
