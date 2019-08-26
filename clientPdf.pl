#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use URI::Escape qw(uri_escape);
use Digest::MD5 qw(md5_hex);

my $base_pdf_api_url = 'https://pdfapi.screenshotmachine.com/?';

my $customer_key = 'PUT_YOUR_CUSTOMER_KEY_HERE';
my $secret_phrase = ''; # leave secret phrase empty, if not needed

my %options;
# mandatory parameter
$options{'url'} = 'https://www.google.com';
# all next parameters are optional, see our website to PDF API guide for more details
$options{'paper'} = 'letter';
$options{'orientation'} = 'portrait';
$options{'media'} = 'print';
$options{'bg'} = 'nobg';
$options{'delay'} = '2000';
$options{'scale'} = '50';

my $api_url = $base_pdf_api_url . 'key=' . $customer_key;
if ($secret_phrase ne "")
{
  $api_url .= '&hash=' . md5_hex($options{'url'} . $secret_phrase);
}
foreach my $key (keys %options) 
{
  $api_url .= '&' . $key . '=' . uri_escape($options{$key});
}

#save PDF file
my $lwp = LWP::UserAgent->new(agent=>'perl-client', cookie_jar=>{});
my $output = 'output.pdf';
my $resp = $lwp->mirror($api_url, $output);
unless($resp->is_success) {
    print $resp->status_line;
}
print "PDF saved as " . $output . "\n";
