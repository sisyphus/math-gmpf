use strict;
use warnings;
use ExtUtils::MakeMaker;

my %options = %{
{
  'NAME' => 'Math::GMPf::V',
  'INC' => $INC,
  'VERSION_FROM' => 'V.pm'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
