use strict;
use warnings;
package Moose::Autobox::Coercions;

use Moose::Util::TypeConstraints;
require Moose::Autobox;

my %_CLASS_FOR = (
  ArrayRef  => 'Moose::Autobox::ARRAY',
  CodeRef   => 'Moose::Autobox::CODE',
  HashRef   => 'Moose::Autobox::HASH',
  ScalarRef => 'Moose::Autobox::SCALAR',
);

for my $from (keys %_CLASS_FOR) {
  class_type($_CLASS_FOR{ $from });
  coerce $_CLASS_FOR{ $from }
    => from $from
    => via  sub { bless $_ => $_CLASS_FOR{ $from } };
}

coerce 'Moose::Autobox::Scalar'
  => from 'Value'
  => via  sub { my $value = $_; bless \$value => 'Moose::Autobox::Scalar' };

1;
