use strict;
use warnings;
use Test::More tests => 5;

{
  package Class;
  use Moose;
  use Moose::Autobox::Coercions;
  require Moose::Autobox;

  has regrets => (
    is  => 'rw',
    isa => 'Moose::Autobox::ARRAY',
    coerce  => 1,
    handles => { also_regret => 'push' },
  );
}

my $obj = Class->new;

$obj->regrets([ qw(1 2 3) ]);

is(
  ref $obj->regrets,
  'Moose::Autobox::ARRAY',
  'the thing we get back is blessed as expected',
);

is(
  $obj->regrets->length,
  3,
  "regrets? we've got a few",
);

is(
  $obj->regrets->reduce(sub { $_[0] + $_[1] }),
  6,
  "the sum of all fea^Wregrets",
);

$obj->also_regret(10);

is(
  $obj->regrets->length,
  4,
  "our delegated 'push' worked",
);

is(
  $obj->regrets->reduce(sub { $_[0] + $_[1] }),
  16,
  "and we get the new proper sum",
)
