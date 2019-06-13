#!/usr/bin/env perl

use strict;
use warnings;

# Validates the "http" and "https" URLs in "issued_dois.json" by trying
# to access the given URLs.  Also attempts to validate the email
# addresses in the DOIs that have these.

use Carp;
use Email::Valid;
use IO::File;
use JSON::PP;
use LWP::UserAgent;

my $fh = IO::File->new( "issued_dois.json", "r" ) or
  croak("Can't open \"issued_dois.json\": $!");

my $raw_json = join( "\n", $fh->getlines() );
$fh->close();

my $json = JSON::PP->new()->utf8()->decode($raw_json);
my $ua   = LWP::UserAgent->new();

foreach my $doi ( sort keys( %{ $json->{'DOIs'} } ) ) {
    printf( "Processing DOI \"%s\"...\n", $doi );

    my $is_ok;
    my $reason;

    foreach my $link ( @{ $json->{'DOIs'}{$doi}{'data_links'} } ) {
        if ( $link =~ /^http/ ) {
            my $res =
              $ua->request( HTTP::Request->new( HEAD => $link ) );
            if ( $res->is_success ) {
                $is_ok = 1;
            }
            else {
                $is_ok  = 0;
                $reason = $res->status_line();
            }
        }
        else {
            # It's an email address.
            if ( Email::Valid->address( -address  => $link,
                                        -mxcheck  => 1,
                                        -tldcheck => 1,
                                        -fqdn     => 1 ) )
            {
                $is_ok = 1;
            }
            else {
                $is_ok  = 0;
                $reason = $Email::Valid::Details;
            }
        }

        if ($is_ok) {
            printf( "Ok\t%s\n", $link );
        }
        else {
            printf( "Bad\t%s\t%s\n", $link, $reason );
        }
    } ## end foreach my $link ( @{ $json...})
} ## end foreach my $doi ( sort keys...)
