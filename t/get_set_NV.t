use strict;
use warnings;
use Math::GMPf qw(:mpf);

print "1..10\n";

my $prec;

$prec = 128; # Cover precisions of all NV's

Rmpf_set_default_prec ($prec);

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
  warn "\n Skipping tests 9 and 10\n \$\@: $@";
  print "ok 9\n";
  print "ok 10\n";
  exit 0;
}

my $ok = 1;

Math::MPFR::Rmpfr_set_default_prec($prec);

my $print_err = 0;

for(-16500..-16350, -1100..-950, -200..200, 900..1050, 16400..16600) {
#for(-16442..-16380, -16381..-16300, -1100..-950, -200..200, 900..1050, 16400..16600) {
#for(-16381..-16300, -1100..-950, -200..200, 900..1050, 16400..16600) {
  my $str = random_string($prec) . "e$_";

  my $mpf  = Math::GMPf->new($str, -2);
  my $mpfr = Math::MPFR->new($str,  2);

  my $mpf_d  = Rmpf_get_NV_rndn($mpf);

  my $mpfr_d = Math::MPFR::Rmpfr_get_NV($mpfr, 0);  # Round towards nearest, ties to even.

  if($mpf_d != $mpfr_d) {
    $ok = 0;
    my $mpf_d_pack   = scalar reverse unpack "h*", pack "F", $mpf_d;
    my $mpfr_d_pack  = scalar reverse unpack "h*", pack "F", $mpfr_d;
    if($print_err < 2) { # give specifics for first 2 errors only.
      warn "$str\nGMPf: $mpf_d_pack\nMPFR: $mpfr_d_pack\n";
      printf("GMPf: %La\n", $mpf_d) if Math::MPFR::_nv_is_float128();
      printf("MPFR: %La\n", $mpfr_d) if Math::MPFR::_nv_is_float128();
      warn  "Difference: ",$mpf_d - $mpfr_d, "\n";
      my @args = Rmpf_deref2($mpf, 2, $prec);
      my $rndaz = Math::GMPf::_rndaz(@args, $prec, 1);
      Math::MPFR::Rmpfr_dump($mpfr);
      print $rndaz, "\n";
      $print_err++;
    }
  }
}

if($ok) {print "ok 9\n"}
else    {print "not ok 9\n"}

$ok = 1;

$prec = 64;

Rmpf_set_default_prec ($prec);
Math::MPFR::Rmpfr_set_default_prec($prec);

warn "\n# Precision: $prec\n";

$print_err = 0;

for(-16500..-16350, -1100..-950, -200..200, 900..1050, 16400..16600) {
#for(-16442..-16380, -16381..-16300, -1100..-950, -200..200, 900..1050, 16400..16600) {
#for(-16381..-16300, -1100..-950, -200..200, 900..1050, 16400..16600) {
  my $str = random_string($prec) . "e$_";

#for my $str('0.1e-16493', '-0.101e-16493', '0.1011e-16493', '0.11e-16493') {

  my $mpf  = Math::GMPf->new($str, -2);
  my $mpfr = Math::MPFR->new($str,  2);

  my $mpf_d  = Rmpf_get_NV_rndn($mpf);

  my $mpfr_d = Math::MPFR::Rmpfr_get_NV($mpfr, 0);  # Round towards nearest, ties to even.

  if($mpf_d != $mpfr_d) {
    $ok = 0;
    my $mpf_d_pack   = scalar reverse unpack "h*", pack "F", $mpf_d;
    my $mpfr_d_pack  = scalar reverse unpack "h*", pack "F", $mpfr_d;
    if($print_err < 2) { # give specifics for first 2 errors only.
      warn "$str\nGMPf: $mpf_d_pack\nMPFR: $mpfr_d_pack\n";
      printf("GMPf: %La\n", $mpf_d) if Math::MPFR::_nv_is_float128();
      printf("MPFR: %La\n", $mpfr_d) if Math::MPFR::_nv_is_float128();
      warn  "Difference: ",$mpf_d - $mpfr_d, "\n";
      my @args = Rmpf_deref2($mpf, 2, $prec);
      my $rndaz = Math::GMPf::_rndaz(@args, $prec, 1);
      Math::MPFR::Rmpfr_dump($mpfr);
      print $rndaz, "\n";
      $print_err++;
    }
  }
}

if($ok) {print "ok 10\n"}
else    {print "not ok 10\n"}

sub random_string {
  my $ret = '';
  for (1..$_[0]) {$ret .= int rand(2)}
  $ret =~ s/^0+//;
  if(int(rand(2))) {$ret =  '0.' . $ret}
  else             {$ret = '-0.' . $ret}
  return $ret;
}


