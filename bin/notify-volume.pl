#!/usr/bin/env perl

use strict;
use warnings;

# Constants
# my $NOTIFICATION_TITLE = "Volumen";
my $MUTED_TEXT = "Silenciado";
my $DUNST_STACK_TAG = "volume-notification";

$ENV{'LANG'} = 'C';
my $info = `pactl list sinks`;

my @info_lines = split(/\n/, $info);

my $volume;
my $mute;
foreach my $line (@info_lines) {
    if ($line =~ /^\s*Mute:/) {
        $mute = $line =~ s/.*\b(yes|no)\b$/$1/r;
        print $mute;
    }
    if ($line =~ /^\s*Volume:/) {
        $volume = $line =~ s/.*\/\s*(\d+)%\s*\/.*/$1/r;
    }
}

my $content = "Volumen: $volume%";
if ($mute eq "yes") {
    $content .= " ($MUTED_TEXT)";
}

qx(dunstify -h "string:x-dunst-stack-tag:$DUNST_STACK_TAG" \\
    -h "int:value:$volume" \\
    "$content");
