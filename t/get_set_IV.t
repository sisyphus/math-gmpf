use strict;
use warnings;
use Config;
use Math::GMPf qw(:mpf);

print "1..26\n";

# Assuming that ivsize is either 4 or 8.

my $uv_max = ~0;
my $iv_max = $uv_max == 4294967295 ? 2147483647 : 9223372036854775807;
my $iv_min = ($iv_max * -1) - 1;
my $prec = $Config{ivsize} * 8;

my($uv_max_string, $iv_max_string, $iv_min_string, $con);

if($prec == 64) {
  $uv_max_string = '0.18446744073709551615e20';
  $iv_max_string = '0.9223372036854775807e19';
  $iv_min_string = '-0.9223372036854775808e19';
}
else {
  $uv_max_string = '0.4294967295e10';
  $iv_max_string = '0.2147483647e10';
  $iv_min_string = '-0.2147483648e10';
}

Rmpf_set_default_prec($prec);

warn "\n # uv_max: $uv_max\n";
warn " # iv_max: $iv_max\n";
warn " # iv_min: $iv_min\n";

if($uv_max == Math::GMPf::MATH_GMPf_UV_MAX()) {print "ok 1\n"}
else {
  warn "\n $uv_max != ", Math::GMPf::MATH_GMPf_UV_MAX(), "\n";
  print "not ok 1\n";
}

if($iv_max == Math::GMPf::MATH_GMPf_IV_MAX()) {print "ok 2\n"}
else {
  warn "\n $iv_max != ", Math::GMPf::MATH_GMPf_IV_MAX(), "\n";
  print "not ok 2\n";
}

if($iv_min == Math::GMPf::MATH_GMPf_IV_MIN()) {print "ok 3\n"}
else {
  warn "\n $iv_min != ", Math::GMPf::MATH_GMPf_IV_MIN(), "\n";
  print "not ok 3\n";
}

my $mpf_uv_max = Math::GMPf->new("$uv_max");
my $mpf_iv_max = Math::GMPf->new("$iv_max");
my $mpf_iv_min = Math::GMPf->new("$iv_min");

if($uv_max == $mpf_uv_max) {print "ok 4\n"}
else {
  warn "\n $uv_max != $mpf_uv_max\n";
  print "not ok 4\n";
}

if($iv_max == $mpf_iv_max) {print "ok 5\n"}
else {
  warn "\n $iv_max != $mpf_iv_max\n";
  print "not ok 5\n";
}

if($iv_min == $mpf_iv_min) {print "ok 6\n"}
else {
  warn "\n $iv_min != $mpf_iv_min\n";
  print "not ok 6\n";
}

if($uv_max_string eq "$mpf_uv_max") {print "ok 7\n"}
else {
  warn "\n $uv_max_string ne $mpf_uv_max\n";
  print "not ok 7\n";
}

if($iv_max_string eq "$mpf_iv_max") {print "ok 8\n"}
else {
  warn "\n $iv_max_string ne $mpf_iv_max\n";
  print "not ok 8\n";
}

if($iv_min_string eq "$mpf_iv_min") {print "ok 9\n"}
else {
  warn "\n $iv_min_string ne $mpf_iv_min\n";
  print "not ok 9\n";
}

if(Rmpf_fits_UV_p($mpf_uv_max)) {print "ok 10\n"}
else {
  warn "\n $mpf_uv_max doesn't fit into a UV\n";
  print "not ok 10\n";
}

if(!Rmpf_fits_UV_p($mpf_uv_max + 1)) {print "ok 11\n"}
else {
  warn "\n ", $mpf_uv_max + 1, " fits into a UV\n";
  print "not ok 11\n";
}

if(Rmpf_fits_IV_p($mpf_iv_max)) {print "ok 12\n"}
else {
  warn "\n $mpf_iv_max doesn't fit into an IV\n";
  print "not ok 12\n";
}

if(!Rmpf_fits_IV_p($mpf_iv_max + 1)) {print "ok 13\n"}
else {
  warn "\n ", $mpf_iv_max + 1, " fits into an IV\n";
  print "not ok 13\n";
}

if(Rmpf_fits_IV_p($mpf_iv_min)) {print "ok 14\n"}
else {
  warn "\n $mpf_iv_min doesn't fit into an IV\n";
  print "not ok 14\n";
}

if(!Rmpf_fits_IV_p($mpf_iv_min - 1)) {print "ok 15\n"}
else {
  warn "\n ", $mpf_iv_min - 1, " fits into an IV\n";
  print "not ok 15\n";
}

my $check = Math::GMPf->new();

Rmpf_set_IV($check, $uv_max);
if($check == $mpf_uv_max) {print "ok 16\n"}
else {
  warn "\n $check != $mpf_uv_max\n";
  print "not ok 16\n";
}

if(Rmpf_get_IV($check) == $uv_max) {print "ok 17\n"}
else {
  warn "\n ", Rmpf_get_IV($check), " != $uv_max\n";
  print "not ok 17\n";
}

Rmpf_set_IV($check, $iv_max);
if($check == $mpf_iv_max) {print "ok 18\n"}
else {
  warn "\n $check != $mpf_iv_max\n";
  print "not ok 18\n";
}

if(Rmpf_get_IV($check) == $iv_max) {print "ok 19\n"}
else {
  warn "\n ", Rmpf_get_IV($check), " != $iv_max\n";
  print "not ok 19\n";
}

Rmpf_set_IV($check, $iv_min);
if($check == $mpf_iv_min) {print "ok 20\n"}
else {
  warn "\n $check != $mpf_iv_min\n";
  print "not ok 20\n";
}

if(Rmpf_get_IV($check) == $iv_min) {print "ok 21\n"}
else {
  warn "\n ", Rmpf_get_IV($check), " != $iv_min\n";
  print "not ok 21\n";
}

eval{$con = Rmpf_get_IV($mpf_uv_max + 1);};

if($@ =~ /^Argument supplied to Rmpf_get_IV does not fit into a UV/) {print "ok 22\n"}
else {
  warn "\n \$\@: $@\n";
  print "not ok 22\n";
}

$con = Rmpf_get_IV($mpf_uv_max + 0.99);

if($con == $uv_max) {print "ok 23\n"}
else {
  warn "\n $con != $uv_max\n";
  print "not ok 23\n";
}

eval{$con = Rmpf_get_IV($mpf_iv_min -1);};

if($@ =~ /^Argument supplied to Rmpf_get_IV does not fit into an IV/) {print "ok 24\n"}
else {
  warn "\n \$\@: $@\n";
  print "not ok 24\n";
}

$con = Rmpf_get_IV($mpf_iv_min - 0.99);

if($con == $iv_min) {print "ok 25\n"}
else {
  warn "\n $con != $iv_min\n";
  print "not ok 25\n";
}

$con = Rmpf_get_IV($mpf_iv_max + 1001);
if($con == $iv_max + 1001) {print "ok 26\n"}
else {
  warn "\n $con != ", $iv_max + 1001, "\n";
  print "not ok 26\n";
}
