use warnings;
use strict;

print "1..1\n";

eval {use Math::GMPf::V;};

if($@) {
  warn "\$\@: $@";
  print "not ok 1\n";
}
else {
  warn "\nGMP Header version (major): ", Math::GMPf::V::___GNU_MP_VERSION(), "\n";
  warn "GMP Header version (minor): ", Math::GMPf::V::___GNU_MP_VERSION_MINOR(), "\n";
  warn "GMP Header version (patchlevel): ", Math::GMPf::V::___GNU_MP_VERSION_PATCHLEVEL(), "\n";
  warn "GMP Library version: ", Math::GMPf::V::gmp_v(), "\n";
  warn "GMP CC: ", Math::GMPf::V::___GMP_CC(), "\n";
  warn "GMP CFLAGS: ", Math::GMPf::V::___GMP_CFLAGS(), "\n";
  print "ok 1\n";
}

my($h_major, $h_minor) = (Math::GMPf::V::___GNU_MP_VERSION(), Math::GMPf::V::___GNU_MP_VERSION_MINOR());

if(($h_major < 4) ||
   ($h_major == 4 && $h_minor < 2)) {
   warn "\n\n      Your GMP Header version is outdated and unsupported.\n",
        "      REMAINING TEST SUITE WILL POSSIBLY FAIL !!!!\n";
}

my @lv = split /\./, Math::GMPf::V::gmp_v();

#warn "$lv[0] $lv[1]\n";

if(($lv[0] < 4) ||
   ($lv[0] == 4 && $lv[1] < 2)) {
   warn "\n\n      Your GMP Library version is outdated and unsupported.\n",
        "      REMAINING TEST SUITE SHOULD INEVITABLY FAIL !!!!\n";
}
