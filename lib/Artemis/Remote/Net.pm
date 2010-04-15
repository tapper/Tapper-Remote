package Artemis::Remote::Net;

use strict;
use warnings;

use Moose;

extends 'Artemis::Remote';

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
                return("Can't connect to MCP: $!");
	}
        return(0);
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

