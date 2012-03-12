use lib 't/lib';
use strict;
use warnings;

use CGI;

use CGI::Snapp::Plugin::RedirectTest;

use Test::More;

# -----------------------------------------------

sub test_a
{
	# Test 1. Don't redirect.
	# Set debug so CGI::Snapp itself outputs log messages.

	my($app)         = CGI::Snapp::Plugin::RedirectTest -> new(maxlevel => 'debug', send_output => 0);
	my($mode_source) = 'rm';
	my($run_mode)    = 'first_rm';

	$app -> mode_param($mode_source);
	$app -> query(CGI -> new({$mode_source => $run_mode}) );
	$app -> run_modes({$run_mode => 'first_sub'});
	$app -> start_mode($run_mode);

	my($output) = $app -> run;

	ok($output =~ /first_sub/, 'Run mode first_sub returned its name');

	return 1;

} # End of test_a.

# -----------------------------------------------

sub test_b
{
	# Test 2. Redirect during prerun phase.
	# Set debug so CGI::Snapp itself outputs log messages.

	my($test_name)   = 'test.prerun.mode';
	my($app)         = CGI::Snapp::Plugin::RedirectTest -> new(maxlevel => 'debug', PARAMS => {$test_name => 1}, send_output => 0);
	my($mode_source) = 'rm';
	my($run_mode)    = 'first_rm';

	$app -> mode_param($mode_source);
	$app -> query(CGI -> new({$mode_source => $run_mode}) );
	$app -> run_modes({$run_mode => 'first_sub'});
	$app -> start_mode($run_mode);

	ok($app -> param($test_name) == 1, "PARAMS => {$test_name => 1} worked");

	my($output) = $app -> run;

	ok($output =~ /first.net.au/, 'redirect(http://first.net.au/) during cgiapp_prerun() worked');

	return 2;

} # End of test_b.

# -----------------------------------------------

sub test_c
{
	# Test 3. Redirect but don't set a status.
	# Set debug so CGI::Snapp itself outputs log messages.

	my($test_name)   = 'test.without.status';
	my($app)         = CGI::Snapp::Plugin::RedirectTest -> new(maxlevel => 'debug', PARAMS => {$test_name => 1}, send_output => 0);
	my($mode_source) = 'rm';
	my($run_mode)    = 'first_rm';

	$app -> mode_param($mode_source);
	$app -> query(CGI -> new({$mode_source => $run_mode}) );
	$app -> run_modes({$run_mode => 'first_sub'});
	$app -> start_mode($run_mode);

	ok($app -> param($test_name) == 1, "PARAMS => {$test_name => 1} worked");

	my($output) = $app -> run;

	ok($output =~ /second.net.au/, 'Check url: redirect(http://second.net.au/) without a status worked');
	ok($output =~ /302 (?:Found|Moved)/, "Check default status: redirect('http://second.net.au/') without a status worked");

	return 3;

} # End of test_c.

# -----------------------------------------------

sub test_d
{
	# Test 4. Redirect and set a status.
	# Set debug so CGI::Snapp itself outputs log messages.

	my($test_name)   = 'test.with.status';
	my($app)         = CGI::Snapp::Plugin::RedirectTest -> new(maxlevel => 'debug', PARAMS => {$test_name => 1}, send_output => 0);
	my($mode_source) = 'rm';
	my($run_mode)    = 'first_rm';

	$app -> mode_param($mode_source);
	$app -> query(CGI -> new({$mode_source => $run_mode}) );
	$app -> run_modes({$run_mode => 'first_sub'});
	$app -> start_mode($run_mode);

	ok($app -> param($test_name) == 1, "PARAMS => {$test_name => 1} worked");

	my($output) = $app -> run;

	ok($output =~ /third.net.au/, 'Check url: redirect(http://third.net.au/) with a status worked');
	ok($output =~ /301 Moved Permanently/, "Check explicit status: redirect('http://third.net.au/', '301 Moved Permanently') with a status worked");

	return 3;

} # End of test_d.

# -----------------------------------------------

sub test_e
{
	# Test 5. Redirect to another URL on the same server.
	# Set debug so CGI::Snapp itself outputs log messages.

	my($test_name)   = 'test.local.url';
	my($app)         = CGI::Snapp::Plugin::RedirectTest -> new(maxlevel => 'debug', PARAMS => {$test_name => 1}, send_output => 0);
	my($mode_source) = 'rm';
	my($run_mode)    = 'first_rm';

	$app -> mode_param($mode_source);
	$app -> query(CGI -> new({$mode_source => $run_mode}) );
	$app -> run_modes({$run_mode => 'first_sub'});
	$app -> start_mode($run_mode);

	ok($app -> param($test_name) == 1, "PARAMS => {$test_name => 1} worked");

	my($output) = $app -> run;

	ok($output =~ /login.html/, 'Check url: redirect(login.html) without a status worked');
	ok($output =~ /302 Found/, "Check default status: redirect(login.html) without a status worked");

	return 3;

} # End of test_e.

# -----------------------------------------------

my($count) = 0;

$count += test_a;
$count += test_b;
$count += test_c;
$count += test_d;
$count += test_e;

done_testing($count);
