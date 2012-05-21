package Tapper::Remote;
# ABSTRACT: Tapper - Common functionality for remote automation libs

use warnings;
use strict;
use Moose;

extends 'Tapper::Base';
has cfg =>  (is => 'rw', isa => 'HashRef', default => sub { {} });

=head2 BUILD

Initialize config.

=cut

sub BUILD
{
        my ($self, $config) = @_;
        $self->{cfg}=$config;
}

=head1 SYNOPSIS

This module contains functions that are equal for all remote Tapper
projects (currently Tapper::PRC and Tapper::Installer).
Tapper::Remote itself does not export functionality but instead is the
base image for all modules of the project.

=cut

1; # End of Tapper::Remote
