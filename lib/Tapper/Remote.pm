package Tapper::Remote;

use warnings;
use strict;
use Moose;

extends 'Tapper::Base';
has cfg =>  (is => 'rw', isa => 'HashRef', default => sub {{mcp_port => 7357, mcp_host => 'localhost'}});

sub BUILD
{
        my ($self, $config) = @_;
        $self->{cfg}=$config;
}


=head1 NAME

Tapper::Remote - Tapper - Common functionality for remote automation libs

=cut

our $VERSION = '3.000010';


=head1 SYNOPSIS

This module contains functions that are equal for all remote Tapper
projects (currently Tapper::PRC and Tapper::Installer).
Tapper::Remote itself does not export functionality but instead is the
base image for all modules of the project.

=head1 EXPORT

Nothing. 

=head1 FUNCTIONS

=head1 AUTHOR

AMD OSRC Tapper Team, C<< <tapper at amd64.org> >>

=head1 BUGS


=head1 COPYRIGHT & LICENSE

Copyright 2008-2011 AMD OSRC Tapper Team, all rights reserved.

This program is released under the following license: freebsd

=cut

1; # End of Tapper::Remote
