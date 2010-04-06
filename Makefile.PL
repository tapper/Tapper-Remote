use inc::Module::Install;

name     'Artemis-Remote';
all_from 'lib/Artemis/Remote.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

