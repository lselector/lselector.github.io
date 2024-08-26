# This file is auto generated from CTlib.pm.in.
# Please edit CTlib.pm.in to make any changes
# -*-Perl-*-
# $Id: CTlib.pm.in,v 1.29 1999/09/21 21:03:01 mpeppler Exp $
# @(#)CTlib.pm	1.27	03/26/99

# Copyright (c) 1995-1997
#   Michael Peppler
#
#   Parts of this file are
#   Copyright (c) 1995 Sybase, Inc.
#
#
#   You may copy this under the terms of the GNU General Public License,
#   or the Artistic License, copies of which should have accompanied
#   your Perl kit.

require 5.002;

use strict;

package Sybase::CTlib::_attribs;

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
    carp "Can't delete or clear attributes from a Sybase::CTlib handle.\n";
}

sub DELETE{ &readonly }
sub CLEAR { &readonly }

package Sybase::CTlib::Att;

use Carp;

sub TIEHASH {
    bless {UseDateTime => 0,
	   UseMoney => 0,
	   UseNumeric => 0,
	   MaxRows => 0}
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
    croak("'$_[1]' is not a valid Sybase::CTlib attribute") if(!exists($_[0]->{$_[1]}));
    $_[0]->{$_[1]} = $_[2];
}

sub readonly { croak "\%Sybase::CTlib::Att is read-only\n" }

sub DELETE{ &readonly }
sub CLEAR { &readonly }

package Sybase::CTlib::DateTime;

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


package Sybase::CTlib::Money;

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

package Sybase::CTlib::Numeric;

# Sybase Numeric/Decimal handling. Again, we set up overloading for
# certain operators (in particular the arithmetic ops.)

use overload ("\"\"" => \&n_str,		# Convert to string
	     "0+" => \&n_num,		# Convert to floating point
	     "<=>" => \&n_cmp,		# Compare
	     "+" => \&n_add,		# These you can guess...
	     "-" => \&n_sub,
	     "*" => \&n_mul,
	     "/" => \&n_div);

    
sub n_str {
    my $self = shift;

    $self->str;
}

sub n_num {
    my $self = shift;

    $self->num;
}

sub n_cmp {
    my ($left, $right, $order) = @_;
    my $ret;

    $ret = $left->cmp($right, $order);
}

sub n_add {
    my ($left, $right) = @_;

    $left->calc($right, '+');
}
sub n_sub {
    my ($left, $right, $order) = @_;

    $left->calc($right, '-', $order);
}
sub n_mul {
    my ($left, $right) = @_;

    $left->calc($right, '*');
}
sub n_div {
    my ($left, $right, $order) = @_;

    $left->calc($right, '/', $order);
}


package Sybase::CTlib;

require Exporter;
use AutoLoader;
require DynaLoader;

use Carp;



use subs qw(CS_SUCCEED CS_FAIL CS_CMD_DONE CS_ROW_COUNT
  CS_ROW_RESULT CS_PARAM_RESULT CS_STATUS_RESULT CS_CURSOR_RESULT
  CS_COMPUTE_RESULT CS_CANCEL_CURRENT);

use vars qw(%Att @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $AUTOLOAD 
	    $res_type %fetchable);

%EXPORT_TAGS = (minimal => [qw(CS_SUCCEED CS_FAIL ct_callback CS_CMD_FAIL)]);

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default
# (move infrequently used names to @EXPORT_OK below)
@EXPORT = qw( ct_callback ct_config cs_dt_info
	CS_12HOUR
	CS_ABSOLUTE
	CS_ACK
	CS_ADD
	CS_ALLMSG_TYPE
	CS_ALLOC
	CS_ALL_CAPS
	CS_ANSI_BINDS
	CS_APPNAME
	CS_ASYNC_IO
	CS_ASYNC_NOTIFS
	CS_BINARY_TYPE
	CS_BIT_TYPE
	CS_BLK_HAS_TEXT
	CS_BOUNDARY_TYPE
	CS_BROWSE_INFO
	CS_BULK_CONT
	CS_BULK_DATA
	CS_BULK_INIT
	CS_BULK_LOGIN
	CS_BUSY
	CS_BYLIST_LEN
	CS_CANBENULL
	CS_CANCELED
	CS_CANCEL_ALL
	CS_CANCEL_ATTN
	CS_CANCEL_CURRENT
	CS_CAP_ARRAYLEN
	CS_CAP_REQUEST
	CS_CAP_RESPONSE
	CS_CHALLENGE_CB
	CS_CHARSETCNV
	CS_CHAR_TYPE
	CS_CLEAR
	CS_CLEAR_FLAG
	CS_CLIENTMSG_CB
	CS_CLIENTMSG_TYPE
	CS_CMD_DONE
	CS_CMD_FAIL
	CS_CMD_NUMBER
	CS_CMD_SUCCEED
	CS_COLUMN_DATA
	CS_COMMBLOCK
	CS_COMPARE
	CS_COMPLETION_CB
	CS_COMPUTEFMT_RESULT
	CS_COMPUTE_RESULT
	CS_COMP_BYLIST
	CS_COMP_COLID
	CS_COMP_ID
	CS_COMP_OP
	CS_CONNECTNAME
	CS_CONSTAT_CONNECTED
	CS_CONSTAT_DEAD
	CS_CONTINUE
	CS_CONV_ERR
	CS_CON_INBAND
	CS_CON_LOGICAL
	CS_CON_NOINBAND
	CS_CON_NOOOB
	CS_CON_OOB
	CS_CON_STATUS
	CS_CSR_ABS
	CS_CSR_FIRST
	CS_CSR_LAST
	CS_CSR_MULTI
	CS_CSR_PREV
	CS_CSR_REL
	CS_CURRENT_CONNECTION
	CS_CURSORNAME
	CS_CURSOR_CLOSE
	CS_CURSOR_DEALLOC
	CS_CURSOR_DECLARE
	CS_CURSOR_DELETE
	CS_CURSOR_FETCH
	CS_CURSOR_INFO
	CS_CURSOR_OPEN
	CS_CURSOR_OPTION
	CS_CURSOR_RESULT
	CS_CURSOR_ROWS
	CS_CURSOR_UPDATE
	CS_CURSTAT_CLOSED
	CS_CURSTAT_DEALLOC
	CS_CURSTAT_DECLARED
	CS_CURSTAT_NONE
	CS_CURSTAT_OPEN
	CS_CURSTAT_RDONLY
	CS_CURSTAT_ROWCOUNT
	CS_CURSTAT_UPDATABLE
	CS_CUR_ID
	CS_CUR_NAME
	CS_CUR_ROWCOUNT
	CS_CUR_STATUS
	CS_DATA_BIN
	CS_DATA_BIT
	CS_DATA_BITN
	CS_DATA_BOUNDARY
	CS_DATA_CHAR
	CS_DATA_DATE4
	CS_DATA_DATE8
	CS_DATA_DATETIMEN
	CS_DATA_DEC
	CS_DATA_FLT4
	CS_DATA_FLT8
	CS_DATA_FLTN
	CS_DATA_IMAGE
	CS_DATA_INT1
	CS_DATA_INT2
	CS_DATA_INT4
	CS_DATA_INT8
	CS_DATA_INTN
	CS_DATA_LBIN
	CS_DATA_LCHAR
	CS_DATA_MNY4
	CS_DATA_MNY8
	CS_DATA_MONEYN
	CS_DATA_NOBIN
	CS_DATA_NOBIT
	CS_DATA_NOBOUNDARY
	CS_DATA_NOCHAR
	CS_DATA_NODATE4
	CS_DATA_NODATE8
	CS_DATA_NODATETIMEN
	CS_DATA_NODEC
	CS_DATA_NOFLT4
	CS_DATA_NOFLT8
	CS_DATA_NOIMAGE
	CS_DATA_NOINT1
	CS_DATA_NOINT2
	CS_DATA_NOINT4
	CS_DATA_NOINT8
	CS_DATA_NOINTN
	CS_DATA_NOLBIN
	CS_DATA_NOLCHAR
	CS_DATA_NOMNY4
	CS_DATA_NOMNY8
	CS_DATA_NOMONEYN
	CS_DATA_NONUM
	CS_DATA_NOSENSITIVITY
	CS_DATA_NOTEXT
	CS_DATA_NOVBIN
	CS_DATA_NOVCHAR
	CS_DATA_NUM
	CS_DATA_SENSITIVITY
	CS_DATA_TEXT
	CS_DATA_VBIN
	CS_DATA_VCHAR
	CS_DATEORDER
	CS_DATES_DMY1
	CS_DATES_DMY1_YYYY
	CS_DATES_DMY2
	CS_DATES_DMY2_YYYY
	CS_DATES_DMY3
	CS_DATES_DMY3_YYYY
	CS_DATES_DMY4
	CS_DATES_DMY4_YYYY
	CS_DATES_DYM1
	CS_DATES_HMS
	CS_DATES_HMS_ALT
	CS_DATES_LONG
	CS_DATES_LONG_ALT
	CS_DATES_MDY1
	CS_DATES_MDY1_YYYY
	CS_DATES_MDY2
	CS_DATES_MDY2_YYYY
	CS_DATES_MDY3
	CS_DATES_MDY3_YYYY
	CS_DATES_MYD1
	CS_DATES_SHORT
	CS_DATES_SHORT_ALT
	CS_DATES_YDM1
	CS_DATES_YMD1
	CS_DATES_YMD1_YYYY
	CS_DATES_YMD2
	CS_DATES_YMD2_YYYY
	CS_DATES_YMD3
	CS_DATES_YMD3_YYYY
	CS_DATETIME4_TYPE
	CS_DATETIME_TYPE
	CS_DAYNAME
	CS_DBG_ALL
	CS_DBG_API_LOGCALL
	CS_DBG_API_STATES
	CS_DBG_ASYNC
	CS_DBG_DIAG
	CS_DBG_ERROR
	CS_DBG_MEM
	CS_DBG_NETWORK
	CS_DBG_PROTOCOL
	CS_DBG_PROTOCOL_STATES
	CS_DEALLOC
	CS_DECIMAL_TYPE
	CS_DEFER_IO
	CS_DEF_PREC
	CS_DEF_SCALE
	CS_DESCIN
	CS_DESCOUT
	CS_DESCRIBE_INPUT
	CS_DESCRIBE_OUTPUT
	CS_DESCRIBE_RESULT
	CS_DIAG_TIMEOUT
	CS_DISABLE_POLL
	CS_DIV
	CS_DT_CONVFMT
	CS_DYNAMIC
	CS_DYN_CURSOR_DECLARE
	CS_EBADLEN
	CS_EBADPARAM
	CS_EBADXLT
	CS_EDIVZERO
	CS_EDOMAIN
	CS_EED_CMD
	CS_EFORMAT
	CS_ENCRYPT_CB
	CS_ENDPOINT
	CS_END_DATA
	CS_END_ITEM
	CS_END_RESULTS
	CS_ENOBIND
	CS_ENOCNVRT
	CS_ENOXLT
	CS_ENULLNOIND
	CS_EOVERFLOW
	CS_EPRECISION
	CS_ERESOURCE
	CS_ESCALE
	CS_ESTYLE
	CS_ESYNTAX
	CS_ETRUNCNOIND
	CS_EUNDERFLOW
	CS_EXECUTE
	CS_EXEC_IMMEDIATE
	CS_EXPOSE_FMTS
	CS_EXPRESSION
	CS_EXTERNAL_ERR
	CS_EXTRA_INF
	CS_FAIL
	CS_FALSE
	CS_FIRST
	CS_FIRST_CHUNK
	CS_FLOAT_TYPE
	CS_FMT_JUSTIFY_RT
	CS_FMT_NULLTERM
	CS_FMT_PADBLANK
	CS_FMT_PADNULL
	CS_FMT_UNUSED
	CS_FORCE_CLOSE
	CS_FORCE_EXIT
	CS_FOR_UPDATE
	CS_GET
	CS_GETATTR
	CS_GETCNT
	CS_GOODDATA
	CS_HASEED
	CS_HIDDEN
	CS_HIDDEN_KEYS
	CS_HOSTNAME
	CS_IDENTITY
	CS_IFILE
	CS_ILLEGAL_TYPE
	CS_IMAGE_TYPE
	CS_INIT
	CS_INPUTVALUE
	CS_INTERNAL_ERR
	CS_INTERRUPT
	CS_INT_TYPE
	CS_IODATA
	CS_ISBROWSE
	CS_KEY
	CS_LANG_CMD
	CS_LAST
	CS_LAST_CHUNK
	CS_LC_ALL
	CS_LC_COLLATE
	CS_LC_CTYPE
	CS_LC_MESSAGE
	CS_LC_MONETARY
	CS_LC_NUMERIC
	CS_LC_TIME
	CS_LOC_PROP
	CS_LOGIN_STATUS
	CS_LOGIN_TIMEOUT
	CS_LONGBINARY_TYPE
	CS_LONGCHAR_TYPE
	CS_LONG_TYPE
	CS_MAXSYB_TYPE
	CS_MAX_CAPVALUE
	CS_MAX_CHAR
	CS_MAX_CONNECT
	CS_MAX_LOCALE
	CS_MAX_MSG
	CS_MAX_NAME
	CS_MAX_NUMLEN
	CS_MAX_OPTION
	CS_MAX_PREC
	CS_MAX_REQ_CAP
	CS_MAX_RES_CAP
	CS_MAX_SCALE
	CS_MAX_SYBTYPE
	CS_MEM_ERROR
	CS_MEM_POOL
	CS_MESSAGE_CB
	CS_MIN_CAPVALUE
	CS_MIN_OPTION
	CS_MIN_PREC
	CS_MIN_REQ_CAP
	CS_MIN_RES_CAP
	CS_MIN_SCALE
	CS_MIN_SYBTYPE
	CS_MIN_USERDATA
	CS_MONEY4_TYPE
	CS_MONEY_TYPE
	CS_MONTH
	CS_MSGLIMIT
	CS_MSGTYPE
	CS_MSG_CMD
	CS_MSG_GETLABELS
	CS_MSG_LABELS
	CS_MSG_RESULT
	CS_MSG_TABLENAME
	CS_MULT
	CS_NETIO
	CS_NEXT
	CS_NOAPI_CHK
	CS_NODATA
	CS_NODEFAULT
	CS_NOINTERRUPT
	CS_NOMSG
	CS_NOTIFY_ALWAYS
	CS_NOTIFY_NOWAIT
	CS_NOTIFY_ONCE
	CS_NOTIFY_WAIT
	CS_NOTIF_CB
	CS_NOTIF_CMD
	CS_NO_COUNT
	CS_NO_LIMIT
	CS_NO_RECOMPILE
	CS_NO_TRUNCATE
	CS_NULLDATA
	CS_NULLTERM
	CS_NUMDATA
	CS_NUMERIC_TYPE
	CS_NUMORDERCOLS
	CS_NUM_COMPUTES
	CS_OBJ_NAME
	CS_OPTION_GET
	CS_OPT_ANSINULL
	CS_OPT_ANSIPERM
	CS_OPT_ARITHABORT
	CS_OPT_ARITHIGNORE
	CS_OPT_AUTHOFF
	CS_OPT_AUTHON
	CS_OPT_CHAINXACTS
	CS_OPT_CHARSET
	CS_OPT_CURCLOSEONXACT
	CS_OPT_CURREAD
	CS_OPT_CURWRITE
	CS_OPT_DATEFIRST
	CS_OPT_DATEFORMAT
	CS_OPT_FIPSFLAG
	CS_OPT_FMTDMY
	CS_OPT_FMTDYM
	CS_OPT_FMTMDY
	CS_OPT_FMTMYD
	CS_OPT_FMTYDM
	CS_OPT_FMTYMD
	CS_OPT_FORCEPLAN
	CS_OPT_FORMATONLY
	CS_OPT_FRIDAY
	CS_OPT_GETDATA
	CS_OPT_IDENTITYOFF
	CS_OPT_IDENTITYON
	CS_OPT_ISOLATION
	CS_OPT_LEVEL1
	CS_OPT_LEVEL3
	CS_OPT_MONDAY
	CS_OPT_NATLANG
	CS_OPT_NOCOUNT
	CS_OPT_NOEXEC
	CS_OPT_PARSEONLY
	CS_OPT_QUOTED_IDENT
	CS_OPT_RESTREES
	CS_OPT_ROWCOUNT
	CS_OPT_SATURDAY
	CS_OPT_SHOWPLAN
	CS_OPT_STATS_IO
	CS_OPT_STATS_TIME
	CS_OPT_STR_RTRUNC
	CS_OPT_SUNDAY
	CS_OPT_TEXTSIZE
	CS_OPT_THURSDAY
	CS_OPT_TRUNCIGNORE
	CS_OPT_TUESDAY
	CS_OPT_WEDNESDAY
	CS_OP_AVG
	CS_OP_COUNT
	CS_OP_MAX
	CS_OP_MIN
	CS_OP_SUM
	CS_ORDERBY_COLS
	CS_PACKAGE_CMD
	CS_PACKETSIZE
	CS_PARAM_RESULT
	CS_PARENT_HANDLE
	CS_PARSE_TREE
	CS_PASSTHRU_EOM
	CS_PASSTHRU_MORE
	CS_PASSWORD
	CS_PENDING
	CS_PREPARE
	CS_PREV
	CS_PROCNAME
	CS_PROTO_BULK
	CS_PROTO_DYNAMIC
	CS_PROTO_DYNPROC
	CS_PROTO_NOBULK
	CS_PROTO_NOTEXT
	CS_PROTO_TEXT
	CS_QUIET
	CS_READ_ONLY
	CS_REAL_TYPE
	CS_RECOMPILE
	CS_RELATIVE
	CS_RENAMED
	CS_REQ_BCP
	CS_REQ_CURSOR
	CS_REQ_DYN
	CS_REQ_LANG
	CS_REQ_MSG
	CS_REQ_MSTMT
	CS_REQ_NOTIF
	CS_REQ_PARAM
	CS_REQ_RPC
	CS_REQ_URGNOTIF
	CS_RES_NOEED
	CS_RES_NOMSG
	CS_RES_NOPARAM
	CS_RES_NOSTRIPBLANKS
	CS_RES_NOTDSDEBUG
	CS_RETURN
	CS_ROWFMT_RESULT
	CS_ROW_COUNT
	CS_ROW_FAIL
	CS_ROW_RESULT
	CS_RPC_CMD
	CS_SEC_APPDEFINED
	CS_SEC_CHALLENGE
	CS_SEC_ENCRYPTION
	CS_SEC_NEGOTIATE
	CS_SEND
	CS_SEND_BULK_CMD
	CS_SEND_DATA_CMD
	CS_SENSITIVITY_TYPE
	CS_SERVERMSG_CB
	CS_SERVERMSG_TYPE
	CS_SERVERNAME
	CS_SET
	CS_SETATTR
	CS_SETCNT
	CS_SET_DBG_FILE
	CS_SET_FLAG
	CS_SET_PROTOCOL_FILE
	CS_SHORTMONTH
	CS_SIGNAL_CB
	CS_SIZEOF
	CS_SMALLINT_TYPE
	CS_SORT
	CS_SQLSTATE_SIZE
	CS_SRC_VALUE
	CS_STATEMENTNAME
	CS_STATUS
	CS_STATUS_RESULT
	CS_SUB
	CS_SUCCEED
	CS_SV_API_FAIL
	CS_SV_COMM_FAIL
	CS_SV_CONFIG_FAIL
	CS_SV_FATAL
	CS_SV_INFORM
	CS_SV_INTERNAL_FAIL
	CS_SV_RESOURCE_FAIL
	CS_SV_RETRY_FAIL
	CS_SYB_CHARSET
	CS_SYB_LANG
	CS_SYB_LANG_CHARSET
	CS_SYB_SORTORDER
	CS_SYNC_IO
	CS_TABNAME
	CS_TABNUM
	CS_TDS_40
	CS_TDS_42
	CS_TDS_46
	CS_TDS_495
	CS_TDS_50
	CS_TDS_VERSION
	CS_TEXTLIMIT
	CS_TEXT_TYPE
	CS_THREAD_RESOURCE
	CS_TIMED_OUT
	CS_TIMEOUT
	CS_TIMESTAMP
	CS_TINYINT_TYPE
	CS_TP_SIZE
	CS_TRANSACTION_NAME
	CS_TRANS_STATE
	CS_TRAN_COMPLETED
	CS_TRAN_FAIL
	CS_TRAN_IN_PROGRESS
	CS_TRAN_STMT_FAIL
	CS_TRAN_UNDEFINED
	CS_TRUE
	CS_TRUNCATED
	CS_TRYING
	CS_TS_SIZE
	CS_UNUSED
	CS_UPDATABLE
	CS_UPDATECOL
	CS_USERDATA
	CS_USERNAME
	CS_USER_ALLOC
	CS_USER_FREE
	CS_USER_MAX_MSGID
	CS_USER_MSGID
	CS_USER_TYPE
	CS_USE_DESC
	CS_VARBINARY_TYPE
	CS_VARCHAR_TYPE
	CS_VERSION
	CS_VERSION_100
	CS_VERSION_KEY
	CS_VER_STRING
	CS_WILDCARD
	CS_ZERO
);
# Other items we are prepared to export if requested
@EXPORT_OK = qw(TRACE_NONE TRACE_ALL TRACE_CREATE TRACE_DESTROY TRACE_SQL
    TRACE_RESULTS TRACE_FETCH TRACE_CURSOR TRACE_PARAMS	TRACE_OVERLOAD
    SQLCA_TYPE SQLCODE_TYPE SQLSTATE_TYPE
    CT_BIND CT_BR_COLUMN CT_BR_TABLE CT_CALLBACK CT_CANCEL CT_CAPABILITY
    CT_CLOSE CT_CMD_ALLOC CT_CMD_DROP CT_CMD_PROPS CT_COMMAND CT_COMPUTE_INFO
    CT_CONFIG CT_CONNECT CT_CON_ALLOC CT_CON_DROP CT_CON_PROPS CT_CON_XFER
    CT_CURSOR CT_DATA_INFO CT_DEBUG CT_DESCRIBE CT_DIAG CT_DYNAMIC
    CT_DYNDESC CT_EXIT CT_FETCH CT_GETFORMAT CT_GETLOGINFO CT_GET_DATA
    CT_INIT CT_KEYDATA CT_LABELS CT_NOTIFICATION CT_OPTIONS CT_PARAM
    CT_POLL CT_RECVPASSTHRU CT_REMOTE_PWD CT_RESULTS CT_RES_INFO CT_SEND
    CT_SENDPASSTHRU CT_SEND_DATA CT_SETLOGINFO CT_USER_FUNC CT_WAKEUP
);


tie %Att, 'Sybase::CTlib::Att';

sub AUTOLOAD {
    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    
    # The second argument to constant() is never used...
    my $val = constant($constname, 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    croak "Your vendor has not defined Sybase::CTlib macro $constname";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap Sybase::CTlib;

# Preloaded methods go here.  Autoload methods go after __END__, and are
# processed by the autosplit program.

# Alias ct_connect to new:

*new = \&ct_connect;

# Use a hash table for fast lookups:

@fetchable{
  &CS_ROW_RESULT,
  &CS_PARAM_RESULT,
  &CS_STATUS_RESULT,
  &CS_CURSOR_RESULT,
  &CS_COMPUTE_RESULT} = (1) x 5;

sub ct_fetchable
{
    $fetchable{$_[1]};
}





sub ct_sql
{
    my($db, $cmd, $sub, $flag) = @_;
    my(@res, $data, $rc);
    local($res_type);  # it's local so that it can be examined by &$sub
    my $fail = 0;

    if($db->{'MaxRows'}) {
	$db->ct_options(&CS_SET, &CS_OPT_ROWCOUNT, $db->{MaxRows},
			&CS_INT_TYPE);
    }
    ($db->ct_execute($cmd) == &CS_SUCCEED) || return undef;

    $res_type = 0;		# avoid 'unitialized variable' warnings...
    $flag = 0 unless $flag;


    while(($rc = $db->ct_results($res_type)) == &CS_SUCCEED) {
        $db->{'ROW_COUNT'} = $db->ct_res_info(&CS_ROW_COUNT)
            if $res_type == &CS_CMD_DONE;
	$fail = 1 if ($res_type == &CS_CMD_FAIL);
	next unless $fetchable{$res_type};

        while ($data = $db->ct_fetch($flag, 1)) {
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
	$db->ct_options(&CS_SET, &CS_OPT_ROWCOUNT, 0, &CS_INT_TYPE);
    }
    $db->{RC} = $fail ? CS_FAIL : $rc;
    wantarray ? @res : \@res;  # return the result array
}

1;
__END__
