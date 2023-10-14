#!/usr/local/bin/perl
use LWP::Simple; 
$address = 'http://tycho.usno.navy.mil/cgi-bin/timer.pl'; 
$page = get($address);

$page =~ m/<h3>(.*?)<\/h3>/smi;
$mytime = $1;
print "Content-type: text/plain\n\n";
print <<EOHTML;
<html><head><title>Atomic Time</title>
<META HTTP-EQUIV="Refresh" CONTENT="2;URL=http://www.selectorweb.com/time.cgi"> 
</head>
<body>
$mytime
</body>
</html>
EOHTML

exit(0);

