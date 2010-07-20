
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'validate assembly stash with Rx (from JSON in kit)',
  'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'Email::MIME::Kit' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Email-MIME-Kit-Validator-Rx',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Email::MIME::Kit::Validator::Rx',
  'PREREQ_PM' => {
    'Data::Rx' => '0.007',
    'Data::Rx::TypeBundle::Perl' => '0.002',
    'Email::MIME::Kit::Role::Validator' => '0',
    'JSON' => '0',
    'Moose' => '0',
    'Moose::Util::TypeConstraints' => '0'
  },
  'VERSION' => '0.102010',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



