use inc::Module::Install;

name     'Artemis-Remote';
all_from 'lib/Artemis/Remote.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';
license  'perl';

build_requires 'Test::More';

requires 'Getopt::Long';
requires 'Moose';
requires 'Net::TFTP';
requires 'Sys::Hostname';
requires 'Socket';
requires 'YAML::Syck';


auto_install;

WriteAll;

