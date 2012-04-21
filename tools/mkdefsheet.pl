use strict;
use warnings;
use 5.010;
use IO::File;

if (scalar(@ARGV) != 1) {
    say "You should specify one (and only one) filename";
    exit(0);
}

my $key = "!";
my $value = "!";

my $dest = IO::File->new($ARGV[0], "w") or die("$!");
$dest->print('
\documentclass[a4paper, 11pt]{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}

\title{Insert Title here}
\author{Who are you ?}
\date{}

\begin{document}
\maketitle
\begin{description}
');

until ($key eq "" or $value eq ""){
    print "Definen : ";
    $key = <STDIN>;
    print "Definiendum : ";
	$value = <STDIN>;
    chomp($key);
    chomp($value);
    $dest->print("\\item[$key] $value\n") unless ($key eq "" or $value eq "");
}

$dest->print('\end{description}
\end{document}');
$dest->close();
