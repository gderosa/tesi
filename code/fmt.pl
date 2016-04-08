#!/usr/bin/perl -w
while(<STDIN>) {
    s/(.{72})/$1\n/g;
    print
}

