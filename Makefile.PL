use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

( my $mmv = ExtUtils::MakeMaker->VERSION() ) =~ s/ _ //smxg;

my $attr = {
  ABSTRACT => 'Calendar of the church year',
  AUTHOR => [
    'Thomas Thurman <tthurman@gnome.org>',
    'Tom Wyant (wyant at cpan dot org)',
  ],
  LICENSE => 'perl',
  META_MERGE => {
    no_index => [
      'inc',
      't',
      'xt',
    ],
    resources => {
      license => 'http://dev.perl.org/licenses/',
    },
  },
  MIN_PERL_VERSION => '5.006',
  NAME => 'DateTime::Calendar::Liturgical::Christian',
  PREREQ_PM => {
    'Date::Calc' => 0,
    Exporter => 0,
    Storable => 0,
  },
  VERSION_FROM => 'lib/DateTime/Calendar/Liturgical/Christian.pm',
}
;

$mmv lt '6.64'
  and merge(
    $attr->{BUILD_REQUIRES},
    delete $attr->{TEST_REQUIRES},
  );

$mmv lt '6.5503'
  and merge(
    $attr->{META_MERGE}{build_requires},
    delete $attr->{BUILD_REQUIRES},
  );

$mmv lt '6.52'
  and merge(
    $attr->{BUILD_REQUIRES},
    delete $attr->{CONFIGURE_REQUIRES},
  );

$mmv lt '6.48'
  and delete $attr->{MIN_PERL_VERSION};

$mmv lt '6.46'
  and delete $attr->{META_MERGE};

$mmv lt '6.31'
  and delete $attr->{LICENSE};

WriteMakefile( %{ $attr } );

sub merge {
  my ( $to, $from ) = @_;
  @{ $to }{ keys %{ $from } } = values %{ $from };
  return;
}

sub MY::postamble {
    my ( $self, @args ) = @_;

    my $authortest = $self->test_via_harness(
	'$(FULLPERLRUN)', '$(AUTHORTEST_FILES)' );
    $authortest =~ s/ \s+ \z //smx;
    $authortest =~ s/ \A \s+ //smx;
    chomp $authortest;

    return <<"EOD";

AUTHORTEST_FILES = t/*.t xt/*.t

authortest : pure_all
	RELEASE_TESTING=1 $authortest

testcover : pure_all
	cover -test
EOD
}
