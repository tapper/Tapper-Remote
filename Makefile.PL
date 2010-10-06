use inc::Module::Install;

name     'Artemis-Remote';
all_from 'lib/Artemis/Remote.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';
license  'perl';

build_requires 'Test::More';
build_requires 'Test::Perl::Critic';

requires 'Getopt::Long';
requires 'Moose';
requires 'Net::TFTP';
requires 'Sys::Hostname';
requires 'Socket';
requires 'YAML::Syck';
requires 'IO::Socket::INET';

auto_install;

postamble("

MOUNT=/opt/artemis/mnt
MOUNT64:=\${MOUNT}64
MOUNT32:=\${MOUNT}32
PKG_DIR=/data/bancroft/artemis/live/repository/packages/artemisutils/
PKG_DIR_DEV=/data/bancroft/artemis/development/repository/packages/artemisutils/

live:
\t./script/dist_upload_wotan.sh dist
\tssh artemis\@bancroft \"cd \${MOUNT64}; sudo chroot \${MOUNT64} /opt/artemis/bin/cpan Artemis::Remote; tar -czf \${PKG_DIR}/opt-artemis64.tar.gz opt/ etc/resolv.conf\"
\tssh artemis\@bancroft \"cd \${MOUNT32}; sudo chroot \${MOUNT32} /opt/artemis/bin/cpan Artemis::Remote; tar -czf \${PKG_DIR}/opt-artemis32.tar.gz opt/ etc/resolv.conf\"



devel: install
\t./script/dist_upload_wotan.sh dist
\tssh artemis\@bancroft \"sudo mv \${MOUNT64}/opt \${MOUNT64}/opt.live; sudo mv \${MOUNT64}/opt.devel \${MOUNT64}/opt;\"
\tssh artemis\@bancroft \"cd \${MOUNT64}; sudo chroot \${MOUNT64} /opt/artemis/bin/cpan Artemis::Remote && tar -czf \${PKG_DIR_DEV}/opt-artemis64_devel.tar.gz opt/ etc/resolv.conf\"
\tssh artemis\@bancroft \"sudo mv \${MOUNT64}/opt \${MOUNT64}/opt.devel; sudo mv \${MOUNT64}/opt.live \${MOUNT64}/opt;\"

\tssh artemis\@bancroft \"sudo mv \${MOUNT32}/opt \${MOUNT32}/opt.live; sudo mv \${MOUNT32}/opt.devel \${MOUNT32}/opt;\"
\tssh artemis\@bancroft \"cd \${MOUNT32}; sudo chroot \${MOUNT64} /opt/artemis/bin/cpan Artemis::Remote && tar -czf \${PKG_DIR_DEV}/opt-artemis32_devel.tar.gz opt/ etc/resolv.conf\"
\tssh artemis\@bancroft \"sudo mv \${MOUNT32}/opt \${MOUNT32}/opt.devel; sudo mv \${MOUNT32}/opt.live \${MOUNT32}/opt;\"



");


WriteAll;

