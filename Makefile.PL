use ExtUtils::MakeMaker;

WriteMakefile(
	      NAME         => 'DateTime::Calendar::Liturgical::Christian',
	      VERSION_FROM => 'lib/DateTime/Calendar/Liturgical/Christian.pm',
              AUTHOR      => 'Thomas Thurman (thomas[at]thurman.org.uk)',
              PREREQ_PM   => {
                'DateTime'      => '0',
                'Date::Calc'    => '0',
              }
            );
