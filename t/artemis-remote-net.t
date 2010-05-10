use strict;
# use warnings;

use Test::More;
use Test::MockModule;

BEGIN {
        use_ok('Artemis::Remote::Net');
 }

my $net = Artemis::Remote::Net->new();


my $report = {
              tests => [
                        {error => 1, test  => 'First test'},
                        { test  => 'Second test' },
                       ],
              headers => {
                          First_header => '1',
                          Second_header => '2',
                         },
             };
my $message = $net->tap_report_create($report);
like($message, qr(# First_header: 1), 'First header in tap_report_create');
like($message, qr(# Second_header: 2), 'Second header in tap_report_create');
like($message, qr(not ok 1 - First test\nok 2 - Second test), 'Testsin tap_report_create');

done_testing;
