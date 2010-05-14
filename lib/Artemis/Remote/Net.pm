package Artemis::Remote::Net;

use strict;
use warnings;

use Moose;

extends 'Artemis::Remote';

use IO::Socket::INET;
use YAML;

=head1 NAME

Artemis::Remote::Net - Communication with MCP

=head1 SYNOPSIS

 use Artemis::Remote::Net;

=head1 FUNCTIONS


=head2 mcp_inform

Simplify sending messages to MCP. Expects message as string.

@param string - message to send to MCP

@return success - 0
@return error   - -1

=cut

sub mcp_inform
{
        my ($self, $msg) = @_;
        my $message = {state => $msg};
        return $self->mcp_send($message);
}


=head2 mcp_send

Tell the MCP server our current status. This is done using a TCP
connection. Expects message as a hash.

@param string - message to send to MCP

@return success - 0
@return error   - error string

=cut

sub mcp_send
{
        my ($self, $message) = @_;
        my $server = $self->cfg->{mcp_host} or return "MCP host unknown";
        my $port   = $self->cfg->{mcp_port} || 7357;


        my $yaml = Dump($message);
	if (my $sock = IO::Socket::INET->new(PeerAddr => $server,
					     PeerPort => $port,
					     Proto    => 'tcp')){
		print $sock ("$yaml");
		close $sock;
	} else {
                $self->log->error("Can't connect to MCP: $!");
	}

        my $report_file = $self->cfg->{files}{report_file};
        $self->cfg($self->get_report_file($self->cfg)) if not $report_file;

        return $self->atomic_write($report_file, $yaml);
}


=head2 tap_report_away

Actually send the tap report to receiver.

@param string - report to be sent

@return success - (0, report id)
@return error   - (1, error string)

=cut

sub tap_report_away
{
        my ($self, $tap) = @_;
        my $reportid;
        if (my $sock = IO::Socket::INET->new(PeerAddr => $self->cfg->{report_server},
					     PeerPort => $self->cfg->{report_port},
					     Proto    => 'tcp')) {
                eval{
                        my $timeout = 100;
                        local $SIG{ALRM}=sub{die("timeout for sending tap report ($timeout seconds) reached.");};
                        alarm($timeout);
                        ($reportid) = <$sock> =~m/(\d+)$/g;
                        $sock->print($tap);
                };
                alarm(0);
                $self->log->error($@) if $@;
		close $sock;
	} else {
                return(1,"Can not connect to report server: $!");
	}
        return (0,$reportid);

}


=head2 tap_report_create

Create a report string from a report in hash form. Since the function only
does data transformation, no error should ever occur.
The expected hash should contain the following keys:
* tests    - contains an array of hashes with
** error   - indicated whether this test failed (if true)
** test    - description of the test
* headers  - Artemis headers with values
* sections - array of hashes containing tests and headers ad described above and
             a section_name

@param hash ref -  report data

@return report string

=cut

sub tap_report_create
{
        my ($self, $report) = @_;
        my $message;
        my @tests = @{$report->{tests}};

        $message .= "1..".int (@tests);
        $message .= "\n";
        foreach my $header (keys %{$report->{headers}}) {
                $message .= "# $header: ";
                $message .= $report->{headers}->{$header};
                $message .= "\n";
        }

        # @tests starts with 0, reports start with 1
        for (my $i=1; $i<=@tests; $i++) {
                $message .= "not " if $tests[$i-1]->{error};
                $message .="ok $i - ";
                $message .= $tests[$i-1]->{test} if $tests[$i-1]->{test};
                $message .="\n";
        }
        return ($message);
}


1;

=head1 AUTHOR

OSRC SysInt Team, C<< <osrc-sysint at elbe.amd.com> >>

=head1 BUGS

None.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

 perldoc Artemis


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 OSRC SysInt Team, all rights reserved.

This program is released under the following license: restrictive

