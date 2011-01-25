package Artemis::Remote;

use warnings;
use strict;
use Moose;

extends 'Artemis::Base';
has cfg =>  (is => 'rw', isa => 'HashRef', default => sub {{mcp_port => 7357, mcp_host => 'localhost'}});

sub BUILD
{
        my ($self, $config) = @_;
        $self->{cfg}=$config;
}


=head1 NAME

Artemis::Remote - Common functionality for all remote projects!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '1.000026';


=head1 SYNOPSIS

This module contains functions that are equal for all remote Artemis
projects (currently Artemis::PRC and Artemis::Installer).
Artemis::Remote itself does not export functionality but instead is the
base image for all modules of the project.

=head1 EXPORT

Nothing. 

=head1 FUNCTIONS

=head1 AUTHOR

OSRC SysInt Team, C<< <osrc-sysint at elbe.amd.com> >>

=head1 BUGS


=head1 COPYRIGHT & LICENSE

Copyright 2010 OSRC SysInt Team, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Artemis::Remote
