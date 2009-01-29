package Email::MIME::Kit::Validator::Rx;
our $VERSION = '0.001';

use Moose;
with 'Email::MIME::Kit::Role::Validator';
# ABSTRACT: validate assembly stash with Rx (from JSON in kit)

use Data::Rx;
use Data::Rx::TypeBundle::Perl 0.002;

use JSON;

has prefix => (
  is  => 'ro',
  isa => 'HashRef',
  default => sub { {} },
);

has type_plugins => (
  is  => 'ro',
  isa => 'ArrayRef[Str]',
  default    => sub { [] },
  auto_deref => 1,
);

has schema => (
  is  => 'ro',
  isa => 'Object',
  lazy     => 1,
  init_arg => undef,
  default  => sub {
    my ($self) = @_;

    for my $plugin ($self->type_plugins) {
      eval "require $plugin; 1" or die;
    }

    my $rx = Data::Rx->new({
      prefix       => $self->prefix,
      type_plugins => [
        'Data::Rx::TypeBundle::Perl',
        $self->type_plugins,
      ],
    });

    my $rx_json_ref = $self->kit->get_kit_entry('rx.json');
    my $rx_data = JSON->new->decode($$rx_json_ref);
    $rx->make_schema($rx_data);
  },
);

sub BUILD {
  my ($self) = @_;
  # we force schema construction now to get it as early as possible
  $self->schema;
}

sub validate {
  my ($self, $stash) = @_;
  Carp::confess("assembly parameters don't pass validation")
    unless $self->schema->check($stash);

  return 1;
}

no Moose;
1;

__END__

=pod

=head1 NAME

Email::MIME::Kit::Validator::Rx - validate assembly stash with Rx (from JSON in kit)

=head1 VERSION

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


