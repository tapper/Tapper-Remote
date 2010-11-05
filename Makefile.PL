use inc::Module::Install;

name     'Artemis-Remote';
all_from 'lib/Artemis/Remote.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';
license  'freebsd';

build_requires 'Test::More';
build_requires 'Test::Perl::Critic';

requires 'Getopt::Long';
requires 'Moose';
requires 'Net::TFTP';
requires 'File::Path';
requires 'Sys::Hostname';
requires 'Socket';
requires 'YAML::Syck';
requires 'IO::Socket::INET';

auto_install;

WriteAll;

