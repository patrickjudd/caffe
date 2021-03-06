#!/usr/bin/perl
#

use Scalar::Util qw(looks_like_number);

$caffeDir = "/localhome/juddpatr/caffe";

$first=1;
$net="";
$baseline=-1;
foreach(<>){

  if ($first) {
    $net = (split /-/)[0];
    $modelDir = "$caffeDir/models/$net";
    $baseline = `cat $modelDir/$net.baseline`;
    $first=0;
    print "$net $baseline\n";
  }
  #split up path
  @dirs = split /\//;
  $runDir = $dirs[-2];
  $runDir =~ /-([\d\.\-,]+)/;
  $config = $1;
  $config =~ s/,/-/g;

  $stats = $dirs[-1];
  $accuracy = (split /\s*,\s*/)[-1];
  chomp($accuracy);

  $relAcc = $accuracy/$baseline;

  printf ("%s, %.4f\n", $config, $relAcc) unless $config eq "";
}
