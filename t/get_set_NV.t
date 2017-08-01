use strict;
use warnings;
use Math::GMPf qw(:mpf);

print "1..8\n";

my $prec;

$prec = Math::GMPf::_required_ldbl_mant_dig() == 2098 ? 2098 : 113;

Rmpf_set_default_prec($prec);

warn "\n# Precision: ", Rmpf_get_default_prec(), "\n";

my $nv = 1.2345678e-53;

my $fi = Rmpf_init();

Rmpf_set_NV($fi, $nv);

# For double-double architectures we need to be able to use a precision of 2098 bits.
# However, with GMP, we get only 2080 or 2112, and nothing in between.
# I'm finding small (off by one ULP) discrepancies - because mpf_get_d (which we need
# to call in Rmpf_get_NV) truncates instead of rounding to nearest.
# Currently we avoid test failures here by testing for "near enough" instead.
# We can, however, expect '==' overloading to be accurate here because it compares $fi
# with another (temporary) 2112 bit Math::GMPf object that has been assigned $nv using
# the exact same function (_Rmpf_set_ld) that assigned $nv to $fi in the first place.

if($fi == $nv) {print "ok 1\n"}
else {
  warn "\n $fi != $nv\n";
  print "not ok 1\n";
}

# With double-double arch we get an off-by-one ULP discrepancy in test 2 if we test for
# equivalence. Therefore we test for "near enough".

if(Rmpf_get_default_prec == 2112) {

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

# With double-double, as for test 1, test 7 also holds good for '==' overloading.

if($fi == $nv) {print "ok 7\n"}
else {
  warn "\n $fi != $nv\n";
  print "not ok 7\n";
}

# With double-double, as for test 2, we also need to test for "near enough" in test 8.

if(Rmpf_get_default_prec == 2112) {

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

__END__

#perl: 1.234567800000000087541178051629e-53 -8.754117805162882394639726134476e-70
#gmp:  1.234567800000000087541178051629e-53 -8.754117805162883681529123501483e-70

#perl: 34f2eb713a90e170b1982adffc09278b
#gmp:  34f2eb713a90e170b1982adffc09278c



