package CGI::Snapp::Plugin::Redirect;

use strict;
use warnings;

use vars qw(@EXPORT @ISA);

@EXPORT = ('redirect');
@ISA    = ('Exporter');

our $VERSION = '1.01';

# --------------------------------------------------

sub redirect
{
	my($self, $url, $status) = @_;
	$url    ||= '';
	$status ||= 0;

	$self -> log(debug => "redirect($url, ...)");

	# If we're in the prerun phase, generate a no-op via a dummy sub.

	if ($self -> _prerun_mode_lock == 0)
	{
		$self -> run_modes(dummy_redirect => sub{});
		$self -> prerun_mode('dummy_redirect');
	}

	if ($status)
	{
		$self -> header_add(-location => $url, -status => $status);
	}
	else
	{
		$self -> header_add(-location => $url);
	}

	$self -> header_type('redirect');

} # End of redirect.

# --------------------------------------------------

1;

=pod

=head1 NAME

CGI::Snapp::Plugin::Redirect - A plugin for CGI::Snapp to simplify using HTTP redirects

=head1 Synopsis

	package My::App;

	use parent 'CGI::Snapp';

	use CGI::Snapp::Plugin::Redirect;

	sub cgiapp_prerun
	{
		my($self) = @_;

		if (<< not logged in >>)
		{
			$self -> redirect('login.html');
		}

	} # End of cgiapp_prerun.

	sub teardown
	{
		my($self) = @_;

		return $self -> redirect('http://www.example.com/', '301 Moved Permanently');

	} # End of teardown.

=head1 Description

When you 'use' this module in your sub-class of L<CGI::Snapp> (as in the Synopsis), it automatically imports into your sub-class the L</redirect($url[, $status])> method, to give you
a single call to set the HTTP headers for redirection to an external $url. See that method's details below for exactly what effect a call to redirect() has.

If you just want to display the results of another run mode within the same application, then L<CGI::Snapp::Plugin::Forward>'s forward() method is more suitable.

=head1 Distributions

This module is available as a Unix-style distro (*.tgz).

See L<http://savage.net.au/Perl-modules/html/installing-a-module.html>
for help on unpacking and installing distros.

=head1 Installation

Install L<CGI::Snapp::Plugin::Redirect> as you would for any C<Perl> module:

Run:

	cpanm CGI::Snapp::Plugin::Redirect

or run:

	sudo cpan CGI::Snapp::Plugin::Redirect

or unpack the distro, and then either:

	perl Build.PL
	./Build
	./Build test
	sudo ./Build install

or:

	perl Makefile.PL
	make (or dmake or nmake)
	make test
	make install

=head1 Constructor and Initialization

This module does not have, and does not need, a constructor.

=head1 Methods

=head2 redirect($url[, $status])

Interrupts the current request, and redirects to the given (external) $url, optionally setting the HTTP status to $status.

Here, the [] indicate an optional parameter.

The redirect happens even if you are inside a method attached to the 'prerun' hook when you call redirect().

Specifically, this method does these 3 things:

=over 4

=item o Sets the HTTP header 'location' to the given $url

=item o Sets the HTTP 'status' (if provided) to $status

=item o Sets the L<CGI::Snapp> header type to 'redirect'

=back

=head1 FAQ

=head2 Why don't you 'use Exporter;'?

It is not needed; it would be for documentation only.

For the record, Exporter V 5.567 ships with Perl 5.8.0. That's what I had in Build.PL and Makefile.PL until I tested the fact I can omit it.

=head1 See Also

L<CGI::Application>

The following are all part of this set of distros:

L<CGI::Snapp> - A almost back-compat fork of CGI::Application

L<CGI::Snapp::Dispatch> - Dispatch requests to CGI::Snapp-based objects

L<CGI::Snapp::Plugin::Forward> - A plugin for CGI::Snapp to switch cleanly to another run mode within the same app

L<CGI::Snapp::Plugin::Redirect> - A plugin for CGI::Snapp to simplify using HTTP redirects

L<CGI::Snapp::Demo::One> - A template-free demo of CGI::Snapp using just 1 run mode

L<CGI::Snapp::Demo::Two> - A template-free demo of CGI::Snapp using N run modes

L<CGI::Snapp::Demo::Three> - A template-free demo of CGI::Snapp using CGI::Snapp::Plugin::Forward

L<CGI::Snapp::Demo::Four> - A template-free demo of CGI::Snapp using Log::Handler::Plugin::DBI

L<CGI::Snapp::Demo::Four::Wrapper> - A wrapper around CGI::Snapp::Demo::Four, to simplify using Log::Handler::Plugin::DBI

L<Config::Plugin::Tiny> - A plugin which uses Config::Tiny

L<Config::Plugin::TinyManifold> - A plugin which uses Config::Tiny with 1 of N sections

L<Data::Session> - Persistent session data management

L<Log::Handler::Plugin::DBI> - A plugin for Log::Handler using Log::Hander::Output::DBI

L<Log::Handler::Plugin::DBI::CreateTable> - A helper for Log::Hander::Output::DBI to create your 'log' table

=head1 Machine-Readable Change Log

The file CHANGES was converted into Changelog.ini by L<Module::Metadata::Changes>.

=head1 Version Numbers

Version numbers < 1.00 represent development versions. From 1.00 up, they are production versions.

=head1 Credits

Please read L<https://metacpan.org/module/CGI::Application::Plugin::Redirect#AUTHOR>, since this code is basically copied from L<CGI::Application::Plugin::Redirect>.

=head1 Support

Email the author, or log a bug on RT:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=CGI::Snapp::Plugin::Redirect>.

=head1 Author

L<CGI::Snapp::Plugin::Redirect> was written by Ron Savage I<E<lt>ron@savage.net.auE<gt>> in 2012.

Home page: L<http://savage.net.au/index.html>.

=head1 Copyright

Australian copyright (c) 2012, Ron Savage.

	All Programs of mine are 'OSI Certified Open Source Software';
	you can redistribute them and/or modify them under the terms of
	The Artistic License, a copy of which is available at:
	http://www.opensource.org/licenses/index.html

=cut
