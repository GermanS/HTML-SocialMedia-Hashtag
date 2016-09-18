use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'HTML::SocialMedia::Hashtag',
    AUTHOR        => q{German Semenkov <german.semenkov@gmail.com>},
    VERSION_FROM  => 'lib/HTML/SocialMedia/Hashtag.pm',
    (
        ( defined( $ExtUtils::MakeMaker::VERSION ) && ( $ExtUtils::MakeMaker::VERSION >= 6.3002 ) )
        ? ('LICENSE'=> 'GPL')
        : ()
    ),
    PL_FILES       => {},
    BUILD_REQUIRES => {
        'Test::More'       => 0,
    },
    PREREQ_PM => {
        'HTML::Strip'     => 0,
        'Class::Accessor' => 0,
    },
    TEST_REQUIRES => {
        'Test::Class' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'HTML-SocialMedia-Hashtag-*' },
    META_MERGE      => {
        'meta-spec' => {
            version => 2
        },
        resources => {
            repository => {
                type => 'git',
                url  => 'git://github.com/nigelhorne/HTML-SocialMedia-Hashtag.git',
                web  => 'https://github.com/GermanS/HTML-SocialMedia-Hashtag',
            },
        },
    },
    MIN_PERL_VERSION => '5.6.2'  # Probably would work
);
