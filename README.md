# screenshotmachine-perl

This demo shows how to call online screenshot machine API using Perl5.

## Installation
First, you need to create a free/premium account at [www.screenshotmachine.com](https://www.screenshotmachine.com) website. After registration, you will see your customer key in your user profile. Also secret phrase is maintained here. Please, use secret phrase always, when your API calls are called from publicly available websites.  

Set-up your customer key and secret phrase (if needed) in the script:

```perl
my $customer_key = 'PUT_YOUR_CUSTOMER_KEY_HERE';
my $secret_phrase = ''; # leave secret phrase empty, if not needed
```

## Website screenshot API
Set additional options to fulfill your needs: 


```perl
my %options;
# mandatory parameter
$options{'url'} = 'https://www.google.com';
# all next parameters are optional, see our website screenshot API guide for more details
$options{'dimension'} = '1366x768'; # or "1366xfull" for full length screenshot
$options{'device'} = 'desktop';
$options{'format'} = 'png';
$options{'cacheLimit'} = '0';
$options{'delay'} = '200';
$options{'zoom'} = '100';
```
More info about options can be found in our [Website screenshot API](https://www.screenshotmachine.com/website-screenshot-api.php).  

#### Sample code


```perl
#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use URI::Escape qw(uri_escape);
use Digest::MD5 qw(md5_hex);

my $base_api_url = 'https://api.screenshotmachine.com/?';

my $customer_key = 'PUT_YOUR_CUSTOMER_KEY_HERE';
my $secret_phrase = ''; # leave secret phrase empty, if not needed

my %options;
# mandatory parameter
$options{'url'} = 'https://www.google.com';
# all next parameters are optional, see our website screenshot API guide for more details
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
```
Generated ```api_url```  link can be placed in ```<img>``` tag or used in your business logic later.

If you need to store captured screenshot as an image, just call:

```perl
#save screenshot as an image
my $lwp = LWP::UserAgent->new(agent=>'perl-client', cookie_jar=>{});
my $output = 'output.png';
my $resp = $lwp->mirror($api_url, $output);
unless($resp->is_success) {
    print $resp->status_line;
}
print "Screenshot saved as " . $output . "\n";
```

Captured screenshot will be saved as ```output.png``` file in current directory.

## Website to PDF API

Set the PDF options: 
```perl
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
```
More info about options can be found in our [Website to PDF API](https://www.screenshotmachine.com/website-to-pdf-api.php).  
#### Sample code

```perl
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
```
Captured PDF will be saved as ```out.pdf``` file in the current directory.
# License

The MIT License (MIT)    