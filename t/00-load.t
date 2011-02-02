#!perl -T

use Test::More tests => 3;

BEGIN {
	use_ok( 'Tapper::Remote' );
	use_ok( 'Tapper::Remote::Config' );
	use_ok( 'Tapper::Remote::Net' );
}

diag( "Testing Tapper::Remote $Tapper::Remote::VERSION, Perl $], $^X" );
