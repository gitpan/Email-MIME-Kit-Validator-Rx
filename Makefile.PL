
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Email-MIME-Kit-Validator-Rx',
  NAME      => 'Email::MIME::Kit::Validator::Rx',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'validate assembly stash with Rx (from JSON in kit)',
  VERSION   => '0.003',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Data::Rx::TypeBundle::Perl" => '0',
    "Data::Rx" => '0.007',
    "Email::MIME::Kit" => '2',
    "JSON" => '2',
  },
);
