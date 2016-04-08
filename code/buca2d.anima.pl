#!/usr/bin/perl -w

use IO::Handle;

autoflush STDOUT 1;
autoflush STDERR 1;

# TODO: use strict; better style..

$gnuplot="gnuplot"; # or complete path

$preamble="buca2d.preamble.gpi";
$function=$ARGV[0];
$dir="$function.d";
$plot="buca2d.plot.gpi";
$format='png';
$t_i=0;
$t_f=10;
$step=0.0065;

mkdir $dir;

open(GNUPLOT,"|$gnuplot");

autoflush GNUPLOT 1;

print GNUPLOT "load \"$preamble\"\n";
print GNUPLOT "load \"$function\"\n";

for($t=$t_i;$t<=$t_f;$t+=$step) {
    $n=sprintf("%07.4f",$t);
    $progress=sprintf("%02d", (($t-$t_i)/($t_f-$t_i))*100 );
    print STDERR "plotting @ t=$n  $progress\%     \r";
    print GNUPLOT "
    	set title \"t=$n\" offset 0,-1
        t=$t
        set output \"$dir/frame.$n.$format\"
        load \"$plot\"
    ";
}
print GNUPLOT "\n";

close(GNUPLOT);

