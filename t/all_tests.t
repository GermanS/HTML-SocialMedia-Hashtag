use strict;
use warnings;

use lib qw(t/lib);

use HTML::SocialMedia::Hashtag::SearchForHashtags;

my @tests = qw(
    HTML::SocialMedia::Hashtag::SearchForHashtags
);

Test::Class -> runtests( @tests );