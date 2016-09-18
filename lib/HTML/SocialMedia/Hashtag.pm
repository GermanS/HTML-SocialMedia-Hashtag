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

use Encode qw(decode encode is_utf8);
use HTML::Strip;

use Moose;
use namespace::autoclean;

has 'text' => ( is => 'rw', isa => 'Str', required => 1 );

=head2 METHODS

=head3 hashtags()

Get lowercaded and unique hashtags from html

=cut

sub hashtags {
    my ( $self ) = @_;

    my @hashtags = map { _encode_utf( lc( _decode_utf( $_ ) ) ) } $self -> all_hashtags();

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

    my %seen = ();

    return grep { ! $seen{ $_ } ++ } @array;
}

sub _encode_utf {
    my ( $string ) = @_;

    my $result = is_utf8( $string )
               ? encode( 'UTF-8', $string )
               : $string;

    if( is_utf8( $result ) ) {
        utf8::downgrade( $result );
    }

    return $result;
}

sub _decode_utf {
    my ( $string ) = @_;

    return is_utf8( $string )
         ? $string
         : decode( 'UTF-8', $string );
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__

=head2 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut