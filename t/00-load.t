#!perl -T

use Test::More tests => 3;

BEGIN {
	use_ok( 'Artemis::Remote' );
	use_ok( 'Artemis::Remote::Config' );
	use_ok( 'Artemis::Remote::Net' );
}

diag( "Testing Artemis::Remote $Artemis::Remote::VERSION, Perl $], $^X" );
