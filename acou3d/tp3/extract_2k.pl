#! /usr/bin/env perl -w
#
# extract_2k.pl
#
# Copyright © 2013 Mathieu Gaborit (matael) <mathieu@matael.org>
#
#
# Distributed under WTFPL terms
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#

use strict;
use 5.012;

use IO::File;
use File::Grep qw/fgrep/;

my $fh = IO::File->new("data_2k.data", ">");
foreach my $file ( <mesure2*>) {
	my @parts = split /_/, $file;
	my $fraction = $parts[2].$parts[3];
	$fraction =~ s/pi//g;
	$fraction = "1" if ($fraction eq "");
	my @matches = fgrep { /2000\.00/ } $file.'/FRF.txt';
	# push @final, [$angle, $matches[0]{matches}{12}];
	$fh->print($fraction."\t".$matches[0]{matches}{12});
}

$fh->close();
