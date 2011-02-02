use strict;
# use warnings;

use Test::More;
use Test::MockModule;

BEGIN {
        use_ok('Tapper::Remote::Config');
 }

my $cfg = Tapper::Remote::Config->new();

$ARGV[0]="--config=t/files/config.yml";
my $retval = $cfg->get_local_data("install");
is($retval, 'No hostname given', 'Installer config needs a TFTP server');
done_testing;
