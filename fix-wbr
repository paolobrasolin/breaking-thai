#!/usr/bin/perl -s
use strict;
#use warnings;
#use Data::Dumper qw(Dumper);

our ($separator, $exceptions) = ($::separator, $::exceptions);

open (FH, "<:utf8", $exceptions) or die "Can't open $exceptions for read: $!";
my @exceptions = <FH>;
close FH or die "Cannot close $exceptions: $!"; 

my @rules;
foreach (@exceptions) {
  my $match = "(?!\p{Thai})".(join ("(".quotemeta($separator).")?", split (/\s|/, $_)))."(?<!\p{Thai})";
  $_ =~ s/\n//g;
  (my $replace = $_) =~ s/\s/$separator/g;
  push @rules, {'match' => $match, 'replace' => $replace};
}
#print Dumper \@rules;

binmode STDOUT, ':utf8';
eof() ? exit : binmode ARGV, ':utf8';
while (<>) {
  my($line) = $_;
  foreach (@rules) {
    $line =~ s/$_->{match}/$_->{replace}/g;
  }
  print $line;
} continue {
  binmode ARGV, ':utf8' if eof && !eof();
}
