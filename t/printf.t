use warnings;
use strict;
use Math::GMPf qw(:mpf);
use Math::BigInt; # for some error checks

print "1..7\n";

$|++;

print "# Using gmp version ", Math::GMPf::gmp_v(), "\n";

my($WR1, $WR2, $RD1, $RD2);

my $mp = Math::GMPf->new(-1234567);
my $int = -17;
my $ul = 56789;
my $string = "A string";
my $ok;

unless($ENV{SISYPHUS_SKIP}) {

  # Because of the way I (sisyphus) build this module with MS
  # Visual Studio, XSubs that take a filehandle as an argument
  # do not work. It therefore suits my purposes to be able to
  # avoid calling (and testing) those particular XSubs

  open($WR1, '>', 'out21.txt') or die "Can't open WR1: $!";
  open($WR2, '>', 'out22.txt') or die "Can't open WR2: $!";

  Rmpf_fprintf(\*$WR1, "An mpf object: %.0Ff ", $mp);

  $mp++;
  Rmpf_fprintf(\*$WR2, "An mpf object: %.0Ff ", $mp);

  Rmpf_fprintf(\*$WR1, "followed by a signed int: $int ");
  $int++;
  Rmpf_fprintf(\*$WR2, "followed by a signed int: $int ");

  Rmpf_fprintf(\*$WR1, "followed by an unsigned long: $ul\n");
  $ul++;
  Rmpf_fprintf(\*$WR2, "followed by an unsigned long: $ul\n");

  Rmpf_fprintf(\*$WR1, "%s ", $string);
  Rmpf_fprintf(\*$WR2, "%s ", $string);

  Rmpf_fprintf(\*$WR1, "and an mpf object again: %.0Ff\n", $mp);
  $mp++;
  Rmpf_fprintf(\*$WR2, "and an mpf object again: %.0Ff\n", $mp);

  close($WR1) or die "Can't close WR1: $!";
  close($WR2) or die "Can't close WR2: $!";
  open($RD1, '<', 'out21.txt') or die "Can't open RD1: $!";
  open($RD2, '<', 'out22.txt') or die "Can't open RD2: $!";

  while(<$RD1>) {
     chomp;
     if($. == 1) {
       if($_ eq 'An mpf object: -1234567 followed by a signed int: -17 followed by an unsigned long: 56789') {$ok .= 'a'}
        else {warn "1a got: $_\n"}
     }
     if($. == 2) {
       if($_ eq 'A string and an mpf object again: -1234566') {$ok .= 'b'}
        else {warn "1b got: $_\n"}
     }
  }

  while(<$RD2>) {
     chomp;
     if($. == 1) {
       if($_ eq 'An mpf object: -1234566 followed by a signed int: -16 followed by an unsigned long: 56790') {$ok .= 'd'}
        else {warn "1d got: $_\n"}
     }
     if($. == 2) {
       if($_ eq 'A string and an mpf object again: -1234565') {$ok .= 'e'}
        else {warn "1e got: $_\n"}
     }
  }

  close($RD1) or die "Can't close RD1: $!";
  close($RD2) or die "Can't close RD2: $!";

  if($ok eq 'abde') {print "ok 1\n"}
  else {print "not ok 1 $ok\n"}

  $ok = '';

}
else {
  warn "\n skipping test one - \$ENV{SISYPHUS_SKIP} is set\n";
  Rmpf_set_IV($mp, -1234565);
  $ul++;
  print "ok 1\n";
}

my $buf;

Rmpf_sprintf($buf, "The mpf object: %.0Ff", $mp, 40);
if ($buf eq 'The mpf object: -1234565') {$ok .= 'a'}
else {warn "2a got: $buf\n"}

#$buf = "$buffer";
$mp *= -1;

my $ret = Rmpf_sprintf($buf, "The mpf object: %.0Ff", $mp, 40);
if ($ret == 23) {$ok .= 'b'}
else {warn "2b got: $ret\n"}
if ($buf eq 'The mpf object: 1234565') {$ok .= 'c'}
else {warn "2c got: $buf\n"}

#$buf = "$buffer";
my $zeroes = 3;

# Locale might have decimal point set to ","
Rmpf_sprintf($buf, "The mpf object: %.${zeroes}Ff", $mp, 40);
if ($buf eq 'The mpf object: 1234565.000' ||
    $buf eq 'The mpf object: 1234565,000') {$ok .= 'd'}
else {warn "2d got: $buf\n"}

#$buf = "$buffer";

$ret = Rmpf_sprintf($buf, "The mpf object: %.${zeroes}Ff", $mp, 40);
if ($ret == 27) {$ok .= 'e'}
else {warn "2e got: $ret\n"}

# Locale might have decimal point set to ","
if ($buf eq 'The mpf object: 1234565.000' ||
    $buf eq 'The mpf object: 1234565,000') {$ok .= 'f'}
else {warn "2f got: $buf\n"}

$ret = Rmpf_sprintf($buf, "$ul", 40);
if($ret == 5) {$ok .= 'g'}
else {warn "2g got: $ret\n"}
if ($buf eq '56790') {$ok .= 'h'}
else {warn "2h got: $buf\n"}

if($ok eq 'abcdefgh') {print "ok 2\n"}
else {print "not ok 2 $ok\n"}

$ok = '';

my $mbi = Math::BigInt->new(123);
eval {Rmpf_printf("%.0Ff", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'a'}
else {warn "3a got: $@\n"}

eval {Rmpf_fprintf(\*STDOUT, "%.0Ff", $mbi);};
if($@ =~ /Unrecognised object/) {$ok .= 'b'}
else {warn "3b got: $@\n"}

eval {Rmpf_sprintf($buf, "%.0Ff", $mbi, 15);};
if($@ =~ /Unrecognised object/) {$ok .= 'c'}
else {warn "3c got: $@\n"}

# no longer have Rmpf_sprintf_ret
#eval {Rmpf_sprintf_ret($buf, "%.0Ff", $mbi);};
#if($@ =~ /Unrecognised object/) {$ok .= 'd'}
#else {warn "3d got: $@\n"}

$ok .= 'd';

eval {Rmpf_fprintf(\*STDOUT, "%.0Ff", $mbi, $ul);};
if($@ =~ /must pass 3 arguments/) {$ok .= 'e'}
else {warn "3e got: $@\n"}

eval {Rmpf_sprintf($buf, "%.0Ff", $mbi, $ul, 10);};
if($@ =~ /must pass 4 arguments/) {$ok .= 'f'}
else {warn "3f got: $@\n"}

if($ok eq 'abcdef') {print "ok 3\n"}
else {warn "not ok 3 $ok\n"}

$ok = '';

$ret = Rmpf_printf("40%% of %Ff", $mp);
if($ret == 21) {$ok .= 'a'}

my $w = 16;

$ret = Rmpf_printf("40%% of %${w}Ff", $mp);
if($ret == 23) {$ok .= 'b'}

$ret = Rmpf_printf("$string of %${w}Ff", $mp);
if($ret == 28) {$ok .= 'c'}

$ret = Rmpf_printf("$ul of %${w}Ff", $mp);
if($ret == 25) {$ok .= 'd'}

$ret = Rmpf_printf('hello world');
if($ret == 11) {$ok .= 'e'}

if($ok eq 'abcde') {print "\nok 4\n"}
else {print "not ok 4 $ok\n"}

eval{require Math::GMPq;};
if(!$@) {
  my $ok = '';
  my $mp = Math::GMPq->new(1234567);

  my $ret = Rmpf_printf("40%% of %Qd", $mp);
  if($ret == 14) {$ok .= 'a'}

  my $w = 10;

  $ret = Rmpf_printf("40%% of %${w}Qd", $mp);
  if($ret == 17) {$ok .= 'b'}

  $ret = Rmpf_printf("$string of %${w}Qd", $mp);
  if($ret == 22) {$ok .= 'c'}

  $ret = Rmpf_printf("$ul of %${w}Qd", $mp);
  if($ret == 19) {$ok .= 'd'}

  if($ok eq 'abcd') {print "\nok 5\n"}
  else {print "not ok 5 $ok\n"}
}
else {
  warn "Skipping test 5 - Math::GMPq not available\n";
  print "ok 5\n";
}

eval{require Math::GMPz;};
if(!$@) {
  my $ok = '';
  my $mpz = Math::GMPz->new(1234567);

  my $ret = Rmpf_printf("40%% of %Zd", $mpz);
  if($ret == 14) {$ok .= 'a'}

  my $w = 10;

  $ret = Rmpf_printf("40%% of %${w}Zd", $mpz);
  if($ret == 17) {$ok .= 'b'}

  $ret = Rmpf_printf("$string of %${w}Zd", $mpz);
  if($ret == 22) {$ok .= 'c'}

  $ret = Rmpf_printf("$ul of %${w}Zd", $mpz);
  if($ret == 19) {$ok .= 'd'}

  if($ok eq 'abcd') {print "\nok 6\n"}
  else {print "not ok 6 $ok\n"}
}
else {
  warn "Skipping test 6 - Math::GMPz not available\n";
  print "ok 6\n";
}

$ok = '';

$mp *= -1;

#$buf = 'X' x 10;

$ret = Rmpf_snprintf($buf, 5, "%.0Ff", $mp, 10);

if($buf eq '-123' && $ret == 8) {$ok .= 'a'}
else {warn "7a: $ret $buf\n"}

$ret = Rmpf_snprintf($buf, 6, "%.0Ff", $mp, 10);

if($ret == 8) {$ok .= 'b'}
else {warn "7b: $ret\n"}

if($buf eq '-1234') {$ok .= 'c'}
else {warn "7c: $buf\n"}

if($ok eq 'abc') {print "ok 7\n"}
else {print "not ok 7\n"}







