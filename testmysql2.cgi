#!/usr/bin/perl -w

print "Content-Type: text/html\n\n";
print "<html>\ntest<br>test<br>\n";

use strict;
use DBI();

my $dbh = DBI->connect("DBI:mysql:database=debt;host=localhost",
                         "ketevan", "igwt1945",
                         {'RaiseError' => 1});
my $sth = $dbh->prepare("SELECT * FROM wp_posts");
$sth->execute;
my $numRows = $sth->rows;
print "numRows = $numRows\n";
print"</html>\n";
exit();
