#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Artemis::Remote' );
}

diag( "Testing Artemis::Remote $Artemis::Remote::VERSION, Perl $], $^X" );
