#!/usr/bin/perl -s
use strict;
use warnings;

our ($separator, $patterns) = ($::separator, $::patterns);

use TeX::Hyphen;
my $hyp = new TeX::Hyphen 'file' => $patterns, 'style' => 'utf8';
sub hyphenator {
  my($word) = @_;
  my $number = 0;
  my $pos;
  for $pos ($hyp->hyphenate($word)) {
    substr($word, $pos + $number, 0) = $separator;
    $number += length($separator);
  }
  $word;
}

binmode STDOUT, ':utf8';
eof() ? exit : binmode ARGV, ':utf8';
while (<>) {
  my($line) = $_;
  $line =~ s/(\p{Thai}+)/hyphenator($1)/ge;
  print $line;
} continue {
  binmode ARGV, ':utf8' if eof && !eof();
}
