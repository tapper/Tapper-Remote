use strict;
use warnings;

use Test::More;
use Test::MockModule;

BEGIN {
        use_ok('Artemis::Remote::Config');
        use_ok('Artemis::Remote::Net');
 }

my $cfg = Artemis::Remote::Config->new();

$ARGV[0]="--config=t/files/config.yml";
my $retval = $cfg->get_local_data("install");

done_testing;
