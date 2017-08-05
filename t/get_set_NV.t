use strict;
use warnings;
use Math::GMPf qw(:mpf);

print "1..9\n";

my $prec;

$prec = 2112; # Cover precisions of all NV's

Rmpf_set_default_prec($prec);

warn "\n# Precision: ", Rmpf_get_default_prec(), "\n";

my $nv = 1.2345678e-53;

my $fi = Rmpf_init();

Rmpf_set_NV($fi, $nv);

if($fi == $nv) {print "ok 1\n"}
else {
  warn "\n $fi != $nv\n";
  print "not ok 1\n";
}

# With double-double arch we get an off-by-one ULP discrepancy in test 2 if we test for
# equivalence. Therefore we test for "near enough".

if(1e250 != 1e250 + 1e-250) { # We have double-double NV

  my $eps = $nv - Rmpf_get_NV($fi);

  if($eps < 1.3e-85 && $eps >= 0) {print "ok 2\n"}
  else {
    warn "\n $nv != ", Rmpf_get_NV($fi), "\n Difference is $eps\n";
    print "not ok 2\n";
  }
}
else {
  if($nv == Rmpf_get_NV($fi)) {print "ok 2\n"}
  else {
    warn "\n $nv != ", Rmpf_get_NV($fi), "\n";
    print "not ok 2\n";
  }
}


my $inf = 999**(999**999);
my $nan = $inf / $inf;

eval {Rmpf_set_NV($fi, $inf);};

if($@ =~ /cannot coerce an Inf to a Math::GMPf object/) {print "ok 3\n"}
else {
  warn "\n \$\@: $@\n";
  print "not ok 3\n";
}

eval {Rmpf_set_NV($fi, $nan);};

if($@ =~ /cannot coerce a NaN to a Math::GMPf object/) {print "ok 4\n"}
else {
  warn "\n \$\@: $@\n";
  print "not ok 4\n";
}

$nv = -123.45678;

Rmpf_set_NV($fi, $nv);

if($fi == $nv) {print "ok 5\n"}
else {
  warn "\n $fi != $nv\n";
  print "not ok 5\n";
}

if($nv == Rmpf_get_NV($fi)) {print "ok 6\n"}
else {
  warn "\n $nv != ", Rmpf_get_NV($fi), "\n";
  print "not ok 6\n";
}

$nv = -123456.78e70;

Rmpf_set_NV($fi, $nv);

if($fi == $nv) {print "ok 7\n"}
else {
  warn "\n $fi != $nv\n";
  print "not ok 7\n";
}

# With double-double, as for test 2, we also need to test for "near enough" in test 8.

if(1e250 != 1e250 + 1e-250) { # We have double-double NV

  my $eps = $nv - Rmpf_get_NV($fi);

  if($eps > -1.12e43 && $eps <= 0) {print "ok 8\n"}
  else {
    warn "\n $nv != ", Rmpf_get_NV($fi), "\n Difference is $eps\n";
    print "not ok 8\n";
  }
}
else {
  if($nv == Rmpf_get_NV($fi)) {print "ok 8\n"}
  else {
    warn "\n $nv != ", Rmpf_get_NV($fi), "\n";
    print "not ok 8\n";
  }
}

my $have_mpfr = 0;

eval {require Math::MPFR;};

unless($@) {$have_mpfr = 1}
else {
  warn "Skipping test 9\n \$\@: $@";
  print "ok 9\n";
  exit 0;
}

my $ok = 1;

for(-1080 .. 1030) {
  my $str = random_string($prec) . "e$_";
  my $mpf  = Math::GMPf->new($str, -2);
  my $mpfr = Math::MPFR->new($str,  2);

  my $mpf_d  = Rmpf_get_NV_rndn($mpf);
  my $mpfr_d = Math::MPFR::Rmpfr_get_NV    ($mpfr, 0);

  if($mpf_d != $mpfr_d) {
    $ok = 0;
    my $mpf_pack  = scalar reverse unpack "h*", pack "d<", $mpf_d;
    my $mpfr_pack = scalar reverse unpack "h*", pack "d<", $mpfr_d;
    warn "$str\nGMPf: $mpf_pack\nMPFR: $mpfr_pack\n";
    warn  "Difference: ",$mpf_d - $mpfr_d, "\n";
  }
}

if($ok) {print "ok 9\n"}
else    {print "not ok 9\n"}

sub random_string {
  my $ret = '';
  for (1..$prec) {$ret .= int rand(2)}
  $ret =~ s/^0+//;
  if(int(rand(2))) {$ret =  '0.' . $ret}
  else             {$ret = '-0.' . $ret}
  return $ret;
}

# -1022, -1023, -1024 can fail

