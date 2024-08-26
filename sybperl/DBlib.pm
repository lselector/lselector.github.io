# This file is auto generated from DBlib.pm.in.
# Please edit DBlib.pm.in to make any changes
# -*-Perl-*-
# $Id: DBlib.pm,v 1.37 1999/05/18 06:02:52 mpeppler Exp $
#
# From:
# 	@(#)DBlib.pm	1.35	03/26/99

# Copyright (c) 1991-1999
#   Michael Peppler
#
#   You may copy this under the terms of the GNU General Public License,
#   or the Artistic License, copies of which should have accompanied
#   your Perl kit.

require 5.002;

use strict;

package Sybase::DBlib::_attribs;

use Carp;


 
sub FIRSTKEY {
    each %{$_[0]};
}

sub NEXTKEY {
    each %{$_[0]};
}

sub EXISTS{ 
    exists($_[0]->{$_[1]});
}

sub readonly {
    carp "Can't delete or clear attributes from a Sybase::DBlib handle.\n";
}

sub DELETE{ &readonly }
sub CLEAR { &readonly }


package Sybase::DBlib::Att;

use Carp;

sub TIEHASH {
    bless {
	UseDateTime => 0,
	UseMoney => 0,
#	   UseNumeric => 0,      # I don't think this can work with DBlib
	MaxRows => 0,
	dbKeepNumeric => 1,
	dbNullIsUndef => 1,
	dbBin0x => 0,
       }
}
sub FETCH { 
    return $_[0]->{$_[1]} if (exists $_[0]->{$_[1]});
    return undef;
}
 
sub FIRSTKEY {
    each %{$_[0]};
}

sub NEXTKEY {
    each %{$_[0]};
}

sub EXISTS{ 
     exists($_[0]->{$_[1]});
}

sub STORE {
    croak("'$_[1]' is not a valid Sybase::DBlib attribute") if(!exists($_[0]->{$_[1]}));
    $_[0]->{$_[1]} = $_[2];
}

sub readonly { croak "\%Sybase::DBlib::Att is read-only\n" }

sub DELETE{ &readonly }
sub CLEAR { &readonly }

package Sybase::DBlib::DateTime;

# Sybase DATETIME handling.

# For converting to Unix time:

require Time::Local;


# Here we set up overloading operators
# for certain operations.

use overload ("\"\"" => \&d_str,		# convert to string
	      "cmp" => \&d_cmp,		# compare two dates
	     "<=>" => \&d_cmp);		# same thing

sub d_str {
    my $self = shift;

    $self->str;
}

sub d_cmp {
    my ($left, $right, $order) = @_;

    $left->cmp($right, $order);
}

sub mktime {
    my $self = shift;
    my (@data, $ret);

    # Wrapped in an eval() in case POSIX is not compiled in this
    # copy of Perl.
    eval {
    require POSIX;		# This isn't very clean, but it speeds
				# up loading for something that is rarely
				# used...
    
    @data = $self->crack;

    $ret = POSIX::mktime($data[7], $data[6], $data[5], $data[2],
			 $data[1], $data[0]-1900);
    };
    $ret;
}

sub timelocal {
    my $self = shift;
    my (@data, $ret);

    @data = $self->crack;

    $ret = Time::Local::timelocal($data[7], $data[6], $data[5], $data[2],
				  $data[1], $data[0]-1900);
}

sub timegm {
    my $self = shift;
    my (@data, $ret);

    @data = $self->crack;

    $ret = Time::Local::timegm($data[7], $data[6], $data[5], $data[2],
			       $data[1], $data[0]-1900);
}

package Sybase::DBlib::Money;

# Sybase MONEY handling. Again, we set up overloading for
# certain operators (in particular the arithmetic ops.)

use overload ("\"\"" => \&m_str,		# Convert to string
	     "0+" => \&m_num,		# Convert to floating point
	     "<=>" => \&m_cmp,		# Compare two money items
	     "+" => \&m_add,		# These you can guess...
	     "-" => \&m_sub,
	     "*" => \&m_mul,
	     "/" => \&m_div);

    
sub m_str {
    my $self = shift;

    $self->str;
}

sub m_num {
    my $self = shift;

    $self->num;
}

sub m_cmp {
    my ($left, $right, $order) = @_;
    my $ret;

    $ret = $left->cmp($right, $order);
}

sub m_add {
    my ($left, $right) = @_;

    $left->calc($right, '+');
}
sub m_sub {
    my ($left, $right, $order) = @_;

    $left->calc($right, '-', $order);
}
sub m_mul {
    my ($left, $right) = @_;

    $left->calc($right, '*');
}
sub m_div {
    my ($left, $right, $order) = @_;

    $left->calc($right, '/', $order);
}

package Sybase::DBlib;

require Exporter;
use AutoLoader;
require DynaLoader;
use Carp;



use subs qw(sql SUCCEED FAIL NO_MORE_RESULTS SYBESMSG INT_CANCEL);

use vars qw(%Att @ISA @EXPORT @EXPORT_OK $AUTOLOAD);
use vars qw($DB_ERROR $nsql_strip_whitespace $nsql_deadlock_retrycount
	   $nsql_deadlock_retrysleep $nsql_deadlock_verbose);

@ISA = qw(Exporter DynaLoader);

@EXPORT = qw( dbmsghandle dberrhandle dbrecftos dbexit
	     BCP_SETL bcp_getl
	     dbsetlogintime dbsettime DBGETTIME
	     DBSETLNATLANG DBSETLCHARSET dbsetversion dbversion
	     dbsetifile dbrpwclr dbrpwset
	     DBLIBVS  FAIL 
	     INT_CANCEL INT_CONTINUE INT_EXIT INT_TIMEOUT
	     MORE_ROWS NO_MORE_RESULTS NO_MORE_ROWS NULL REG_ROW
	     STDEXIT SUCCEED SYBESMSG 
	     BCPBATCH BCPERRFILE BCPFIRST BCPLAST BCPMAXERRS	BCPNAMELEN
	     DBBOTH DBSINGLE DB_IN DB_OUT
	     TRUE FALSE
	     DBARITHABORT DBARITHIGNORE DBBUFFER DBBUFSIZE DBDATEFORMAT
	     DBNATLANG DBNOAUTOFREE DBNOCOUNT DBNOEXEC DBNUMOPTIONS
	     DBOFFSET DBROWCOUNT DBSHOWPLAN DBSTAT DBSTORPROCID
	     DBTEXTLIMIT DBTEXTSIZE DBTXPLEN DBTXTSLEN
	     NOSUCHOPTION
	     SYBBINARY SYBBIT SYBCHAR SYBDATETIME SYBDATETIME4
	     SYBFLT8 SYBIMAGE SYBINT1 SYBINT2 SYBINT4 SYBMONEY
	     SYBMONEY4 SYBREAL SYBTEXT SYBVARBINARY SYBVARCHAR
	     DBRPCRETURN DBRPCNORETURN DBRPCRECOMPILE
	      DBRESULT DBNOTIFICATION DBINTERRUPT DBTIMEOUT
	      $DB_ERROR
	     );

@EXPORT_OK = qw(ERREXIT EXCEPTION EXCLIPBOARD EXCOMM EXCONSISTENCY EXCONVERSION
	EXDBLIB EXECDONE EXFATAL EXFORMS EXINFO EXLOOKUP EXNONFATAL EXPROGRAM
	EXRESOURCE EXSCREENIO EXSERVER EXSIGNAL	EXTIME EXUSER
	SYBEAAMT SYBEABMT SYBEABNC SYBEABNP SYBEABNV SYBEACNV SYBEADST SYBEAICF
	SYBEALTT SYBEAOLF SYBEAPCT SYBEAPUT SYBEARDI SYBEARDL SYBEASEC SYBEASNL
	SYBEASTF SYBEASTL SYBEASUL SYBEAUTN SYBEBADPK SYBEBBCI SYBEBCBC
	SYBEBCFO SYBEBCIS SYBEBCIT SYBEBCNL SYBEBCNN SYBEBCNT SYBEBCOR SYBEBCPB
	SYBEBCPI SYBEBCPN SYBEBCRE SYBEBCRO SYBEBCSA SYBEBCSI SYBEBCUC SYBEBCUO
	SYBEBCVH SYBEBCWE SYBEBDIO SYBEBEOF SYBEBIHC SYBEBIVI SYBEBNCR SYBEBPKS
	SYBEBRFF SYBEBTMT SYBEBTOK SYBEBTYP SYBEBUCE SYBEBUCF SYBEBUDF SYBEBUFF
	SYBEBUFL SYBEBUOE SYBEBUOF SYBEBWEF SYBEBWFF SYBECDNS SYBECLOS
	SYBECLOSEIN SYBECLPR SYBECNOR SYBECNOV SYBECOFL SYBECONN SYBECRNC
	SYBECSYN SYBECUFL SYBECWLL SYBEDBPS SYBEDDNE SYBEDIVZ SYBEDNTI SYBEDPOR
	SYBEDVOR SYBEECAN SYBEECRT SYBEEINI SYBEEQVA SYBEESSL SYBEETD SYBEEUNR
	SYBEEVOP SYBEEVST SYBEFCON SYBEFGTL SYBEFMODE SYBEFSHD SYBEGENOS
	SYBEICN SYBEIDCL SYBEIFCL SYBEIFNB SYBEIICL SYBEIMCL SYBEINLN SYBEINTF
	SYBEIPV SYBEISOI SYBEITIM SYBEKBCI SYBEKBCO SYBEMEM SYBEMOV SYBEMPLL
	SYBEMVOR SYBENBUF SYBENBVP SYBENDC SYBENDTP SYBENEHA SYBENHAN SYBENLNL
	SYBENMOB SYBENOEV SYBENOTI SYBENPRM SYBENSIP SYBENTLL SYBENTST SYBENTTN
	SYBENULL SYBENULP SYBENUM SYBENXID SYBEOOB SYBEOPIN SYBEOPNA SYBEOPTNO
	SYBEOREN SYBEORPF SYBEOSSL SYBEPAGE SYBEPOLL SYBEPRTF SYBEPWD SYBERDCN
	SYBERDNR SYBEREAD SYBERFILE SYBERPCS SYBERPIL SYBERPNA SYBERPND
	SYBERPUL SYBERTCC SYBERTSC SYBERTYPE SYBERXID SYBESEFA SYBESEOF
	SYBESFOV SYBESLCT SYBESOCK SYBESPID SYBESYNC SYBETEXS
	SYBETIME SYBETMCF SYBETMTD SYBETPAR SYBETPTN SYBETRAC SYBETRAN
	SYBETRAS SYBETRSN SYBETSIT SYBETTS SYBETYPE SYBEUACS SYBEUAVE SYBEUCPT
	SYBEUCRR SYBEUDTY SYBEUFDS SYBEUFDT SYBEUHST SYBEUNAM SYBEUNOP SYBEUNT
	SYBEURCI SYBEUREI SYBEUREM SYBEURES SYBEURMI SYBEUSCT SYBEUTDS SYBEUVBF
	SYBEUVDT SYBEVDPT SYBEVMS SYBEVOIDRET SYBEWAID SYBEWRIT SYBEXOCI
	SYBEXTDN SYBEXTN SYBEXTSN SYBEZTXT
);

tie %Att, 'Sybase::DBlib::Att';

sub AUTOLOAD {
    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    croak "Your vendor has not defined Sybase::DBlib macro $constname";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap Sybase::DBlib;

# Preloaded methods go here.  Autoload methods go after __END__, and are
# processed by the autosplit program.

# Alias dblogin to new:
*new = \&dblogin;



sub dbsucceed
{
    my($self) = shift;
    my($abort) = shift;
    my($ret);
    
    if(($ret = $self->dbsqlexec) == &SUCCEED)
    {
	$ret = $self->dbresults;
    }

    croak "dbsucceed failed\n" if($abort && $ret == &FAIL);

    $ret;
}

sub dbclose
{
    undef($_[0]);
}


sub sql				# Submitted by Gisle Aas
{
    my($db, $cmd, $sub, $flag) = @_;
    my @res;
    my $data;

    if($db->{'MaxRows'}) {
	$db->dbsetopt(&DBROWCOUNT, "$db->{'MaxRows'}");
    }

    $db->dbcmd($cmd);
    $db->dbsqlexec || return undef; # The SQL command failed

    $flag = 0 unless $flag;
    
    while(my $ret = $db->dbresults != &NO_MORE_RESULTS) {
	if($ret == FAIL) {
	    $db->dbcancel();
	    return undef;
	}
        while ($data = $db->dbnextrow($flag, 1)) {
            if (defined $sub) {
		if($flag) {
		    &$sub(%$data);
		} else {
		    &$sub(@$data);
		}
            } else {
		if($flag) {
		    push(@res, {%$data});
		} else {
		    push(@res, [@$data]);
		}
            }
        }
    }
    
    if($db->{'MaxRows'}) {
	$db->dbsetopt(&DBROWCOUNT, "0");
    }
    
    wantarray ? @res : \@res;  # return the result array
}

sub r_sql {
    my($db, $cmd, $sub) = @_;

    $db->dbcmd($cmd);
    $db->dbsqlexec || return undef; # The SQL command failed

    my @res;
    my @data;
    while($db->dbresults != &NO_MORE_RESULTS) {
        while (@data = $db->dbnextrow) {
            if (defined $sub) {
                &$sub(@data);
            } else {
                push(@res, [@data]);
            }
        }
    }
    @res;  # return the result array
}


#
# Enhanced sql routine.
# 

sub DB_ERROR { return $DB_ERROR; }
 

sub nsql {

    my ($db,$sql,$type,$callback) = @_;
    my (@res,@data,%data);
    my $retrycount = $nsql_deadlock_retrycount;
    my $retrysleep = $nsql_deadlock_retrysleep || 60;
    my $retryverbose = $nsql_deadlock_verbose;

    if ( ref $type ) {
	$type = ref $type;
    }
    elsif ( not defined $type ) {
	$type = "";
    }

    undef $DB_ERROR;
 
  DEADLOCK:
    {	
	
	return unless $db->dbcmd($sql);
	
	unless ( $db->dbsqlexec ) {
	    
	    if ( $nsql_deadlock_retrycount && $DB_ERROR =~ /Message: 1205\b/m ) {
		if ( $retrycount < 0 || $retrycount-- ) {
		    carp "SQL deadlock encountered.  Retrying...\n" if $retryverbose;
		    undef $DB_ERROR;
		    sleep($retrysleep);
		    redo DEADLOCK;
		}
		else {
		    carp "SQL deadlock retry failed $nsql_deadlock_retrycount times.  Aborting.\n"
		      if $retryverbose;
		    last DEADLOCK;
		}
	    }
	    
	    last DEADLOCK;
	    
	}
	
	while ( $db->dbresults != $db->NO_MORE_RESULTS ) {
	    
	    if ( $nsql_deadlock_retrycount && $DB_ERROR =~ /Message: 1205\b/m ) {
		if ( $retrycount < 0 || $retrycount-- ) {
		    carp "SQL deadlock encountered.  Retrying...\n" if $retryverbose;
		    undef $DB_ERROR;
		    @res = ();
		    sleep($retrysleep);
		    redo DEADLOCK;
		}
		else {
		    carp "SQL deadlock retry failed $nsql_deadlock_retrycount times.  Aborting.\n"
		      if $retryverbose;
		    last DEADLOCK;
		}
	    }
	    
	    if ( $type eq "HASH" ) {
		while ( %data = $db->dbnextrow(1) ) {
		    grep($data{$_} =~ s/\s+$//g,keys %data) if $nsql_strip_whitespace;
		    if ( ref $callback eq "CODE" ) {
			unless ( $callback->(%data) ) {
			    $db->dbcancel();
			    $DB_ERROR = "User-defined callback subroutine failed\n";
			    return;
			} 
		    }
		    else {
			push(@res,{%data});
		    }
		}
	    }
	    elsif ( $type eq "ARRAY" ) {
		while ( @data = $db->dbnextrow ) {
		    grep(s/\s+$//g,@data) if $nsql_strip_whitespace;
		    if ( ref $callback eq "CODE" ) {
			unless ( $callback->(@data) ) {
			    $db->dbcancel();
			    $DB_ERROR = "User-defined callback subroutine failed\n";
			    return;
			} 
		    }
		    else {
			push(@res,( $#data == 0 ? @data : [@data] ));
		    }
		}
	    }
	    else {
		# If you ask for nothing, you get nothing.  But suck out
		# the data just in case.
		while ( @data = $db->dbnextrow ) { 1; }
		$res[0]++;	# Return non-null (true)
	    }
	    
	}
	
	last DEADLOCK;
	
    }

    #
    # If we picked any sort of error, then don't feed the data back.
    #
    if ( $DB_ERROR ) {
	return;
    }
    elsif ( ref $callback eq "CODE" ) {
	return 1;
    }
    else {
	return @res;
    }

}

sub nsql_error_handler {
    my ($db, $severity, $error, $os_error, $error_msg, $os_error_msg) = @_;
    # Check the error code to see if we should report this.

    if ( $error != SYBESMSG ) {
      $DB_ERROR = "Sybase error: $error_msg\n";
      $DB_ERROR .= "OS Error: $os_error_msg\n" if defined $os_error_msg;
    }

    INT_CANCEL;
}

sub nsql_message_handler {
    my ($db, $message, $state, $severity, $text, $server, $procedure, $line) = @_;

    if ( $severity > 0 ) {
      $DB_ERROR = "Message: $message\n";
      $DB_ERROR .= "Severity: $severity\n";
      $DB_ERROR .= "State: $state\n";
      $DB_ERROR .= "Server: $server\n" if defined $server;
      $DB_ERROR .= "Procedure: $procedure\n" if defined $procedure;
      $DB_ERROR .= "Line: $line\n" if defined $line;
      $DB_ERROR .= "Text: $text\n";

      return unless ref $db;
      
      my ($lineno) = 1;
      my $row;
      foreach $row ( split(/\n/,$db->dbstrcpy) ) {
          $DB_ERROR .= sprintf ("%5d", $lineno ++) . "> $row\n";
      }
    }
    
    0;
}


1;
__END__
