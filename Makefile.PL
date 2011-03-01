use strict;
use warnings;

use inc::Module::Install;

name     'Tapper-Remote';
all_from 'lib/Tapper/Remote.pm';
author   'AMD OSRC Tapper Team <tapper@amd64.org>';
license  'freebsd';

build_requires 'Test::More';
build_requires 'Test::Perl::Critic';

author_requires 'Module::Install::WriteAll';

requires 'Getopt::Long';
requires 'Moose';
requires 'Net::TFTP' => "0.19";
requires 'File::Path';
requires 'Sys::Hostname';
requires 'Socket';
requires 'YAML::Syck';
requires 'IO::Socket::INET';
requires 'Tapper::Base' => "3.000001";

auto_install;

WriteAll;

