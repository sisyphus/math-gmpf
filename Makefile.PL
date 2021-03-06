use strict;
use warnings;
use Config;
use ExtUtils::MakeMaker;

require 5.006;

$| = 1;

our %args = map { split /\s*=\s*/ } @ARGV;
our $LIBS = $args{ LIBS } || "-lgmp";
our $INC = $args{ INC };

print "\nThis module requires gmp-4.2.0 (or later)\n\n";

my $use_64_bit_int = 0; # Let perl decide whether to include 64-bit 'long long' support
my $use_long_double = 0;# Let perl decide whether to include 'long double' support

#$use_64_bit_int = -1; # Force exclusion of 64-bit 'long long' support
#$use_long_double = -1;# Force exclusion of 'long double' support

#$use_64_bit_int = 1; # Force inclusion of 64-bit 'long long' support
#$use_long_double = 1;# Force inclusion of 'long double' support

my $defines = $] < 5.008 ? "-DOLDPERL" : "-DNEWPERL";

if($use_64_bit_int == -1) {}
elsif($use_64_bit_int == 1) {$defines .= " -DMATH_GMPF_NEED_LONG_LONG_INT"}
else {
  unless($Config{ivsize} < 8 || $Config{ivtype} eq 'long') {
    $defines .= " -DMATH_GMPF_NEED_LONG_LONG_INT";
  }
}

if($use_long_double == -1) {}
elsif($use_long_double == 1) {$defines .= " -DUSE_LONG_DOUBLE"}
else {
  $defines .= " -DNV_IS_FLOAT128" if $Config{nvtype} eq '__float128';
  $defines .= " -DNV_IS_LONG_DOUBLE" if $Config{nvtype} eq 'long double';
  $defines .= " -DNV_IS_DOUBLE" if $Config{nvtype} eq 'double';
}


$defines =~ /-DMATH_GMPF_NEED_LONG_LONG_INT/ ? print "Building with 64-bit'long long' support\n" :
                                 print "Building without 64-bit 'long long' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

$defines =~ /-DNV_IS_LONG_DOUBLE/ ? print "Building with 'long double' support\n" :
                                 print "Building without 'long double' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

$defines =~ /-DNV_IS_FLOAT128/ ? print "Building with '__float128' support\n" :
                                 print "Building without '__float128' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

if($^O =~ /MSWin32/i && $] < 5.022) {$defines .= " -D_WIN32_BIZARRE_INFNAN"}

my %options = (
  NAME => 'Math::GMPf',
  AUTHOR => 'Sisyphus (sisyphus at (@) cpan dot (.) org)',
  ABSTRACT => 'Perl interface to the GMP floating point functions',
  DEFINE   => $defines,
  LIBS => [
    '-lgmp'
  ],
  LICENSE  => 'perl',
  VERSION_FROM => 'GMPf.pm',
  PREREQ_PM => {'Exporter' => '5.58'}, # avoid test failures on pre perl-5.8.4
  clean   => { FILES => 'out1.txt out2.txt out3.txt out4.txt out5.txt out6.txt out7.txt out21.txt out22.txt' },
  META_MERGE => {
   'meta-spec' => { version => 2 },
    resources => {
      repository => {
        type => 'git',
        url => 'https://github.com/sisyphus/math-gmpf.git',
        web => 'https://github.com/sisyphus/math-gmpf',
      },
    },
  },
);

WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
# sub MY::makefile { '' }

