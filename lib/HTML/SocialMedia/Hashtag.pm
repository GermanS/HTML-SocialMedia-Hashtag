package HTML::SocialMedia::Hashtag;

use strict;
use warnings;

=head1 NAME

HTML::SocialMedia::Hashtag

=head2 DESCRIPTION

Get #hashtags and @usernames from html

=head2 SYNOPSIS

    use HTML::SocialMedia::Hashtag;
    my $scanner = HTML::SocialMedia::Hashtag -> new( text => 'text with #hashtag and @username' );
    my @hashtags  = $object -> hashtags();
    my @usernames = $object -> usernames();

=cut

our $VERSION = '0.1';

use HTML::Strip;

use Class::Accessor qw(antlers);


has 'text' => ( is => 'rw' );

=head2 METHODS

=head3 hashtags()

Get lowercaded and unique hashtags from html

=cut

sub hashtags {
    my ( $self ) = @_;

    my @hashtags = map { lc( $_ ) } $self -> all_hashtags();

    return _uniq_array( @hashtags );
}

=head3 all_hashtags()

Get all hashtags from html

=cut

sub all_hashtags {
    my ( $self ) = @_;

    my $strip = HTML::Strip -> new();
    $strip -> set_decode_entities( 0 );

    my $parsed_text = $strip -> parse( $self -> text() );

    my @all_hashtags;

    while ( $parsed_text =~ /(^|\s|>)\#(\S+)/gxo ) {
        my $hashtag = $2;

        $hashtag =~ s/(,)*$//g;
        $hashtag =~ s/(!)*!$//g;
        $hashtag =~ s/(\.)*$//g;
        $hashtag =~ s/(\?)*$//g;
        $hashtag =~ s/(<).*$//g;

        push @all_hashtags, $hashtag;
    }

    return @all_hashtags;
}

sub _uniq_array {
    my ( @array ) = @_;

    #TODO: implement mee

    return @array;
}

1;

__END__

=head2 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut