use strict;
use warnings;
use Config;
use Math::GMPf qw(:mpf);

use Test::More;

my($have_mpz, $have_mpq) = (0, 0);

eval {require Math::GMPz;};
$have_mpz = 1 unless $@;

eval {require Math::GMPq;};
$have_mpq = 1 unless $@;

my $buflen = 32;
my $buf;
my $nv = sqrt(2);

if($Config{nvtype} eq 'double') {
  Rmpf_sprintf($buf, "%.14g", $nv, $buflen);
  cmp_ok($buf, 'eq', '1.4142135623731', "sqrt 2 ok for 'double'");
}

unless($^O =~ /MSWin32/i && $Config{archname} =~ /x86/) {
  # I have no fucking idea why this stipulation should be needed.
  # All I know is that it *is* needed.
  if($Config{nvtype} eq 'long double') {
    Rmpf_sprintf($buf, "%.14Lg", $nv, $buflen);
    cmp_ok($buf, 'eq', '1.4142135623731', "sqrt 2 ok for 'long double'");
  }
}

Rmpf_sprintf($buf, "%.14Fg", sqrt(Math::GMPf->new(2)), $buflen);
cmp_ok($buf, 'eq', '1.4142135623731', "Math::GMPf: sqrt 2 ok");

Rmpf_sprintf($buf, "%s", 'hello world', $buflen);
cmp_ok($buf, 'eq', 'hello world', "'hello world' ok for PV");

if($have_mpz) {
  Rmpf_sprintf($buf, "%Zd", Math::GMPz->new(~0), $buflen);
  cmp_ok($buf, 'eq', '18446744073709551615', "Math::GMPz: ~0 ok");
}

if($have_mpq) {
  Rmpf_sprintf($buf, "%Qd", Math::GMPq->new('19/21'), $buflen);
  cmp_ok($buf, 'eq', '19/21', "Math::GMPq: 19/21 ok");
}

done_testing();
