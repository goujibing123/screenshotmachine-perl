#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use URI::Escape qw(uri_escape);
use Digest::MD5 qw(md5_hex);

my $base_api_url = 'http://api.screenshotmachine.com/?';

my $customer_key = 'PUT_YOUR_CUSTOMER_KEY_HERE';
my $secret_phrase = ''; # leave secret phrase empty, if not needed

my %options;
# mandatory parameter
$options{'url'} = 'https://www.google.com';
# all next parameters are optional, see our API guide for more details
$options{'dimension'} = '1366x768'; # or "1366xfull" for full length screenshot
$options{'device'} = 'desktop';
$options{'format'} = 'png';
$options{'cacheLimit'} = '0';
$options{'delay'} = '200';
$options{'zoom'} = '100';

my $api_url = $base_api_url . 'key=' . $customer_key;
if ($secret_phrase ne "")
{
  $api_url .= '&hash=' . md5_hex($options{'url'} . $secret_phrase);
}
foreach my $key (keys %options) 
{
  $api_url .= '&' . $key . '=' . uri_escape($options{$key});
}
# put link to your html code
print "<img src=\"" . $api_url . "\">\n";

# or save screenshot as an image
my $lwp = LWP::UserAgent->new(agent=>'perl-client', cookie_jar=>{});
my $output = 'output.png';
my $resp = $lwp->mirror($api_url, $output);
unless($resp->is_success) {
    print $resp->status_line;
}
print "Screenshot saved as " . $output . "\n";
