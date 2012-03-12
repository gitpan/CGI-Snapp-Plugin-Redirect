use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
 ($] ge '5.005') ?
 (
  AUTHOR   => 'Ron Savage (ron@savage.net.au)',
  ABSTRACT => 'A plugin for CGI::Snapp to simplify using HTTP redirects',
    ) : (),
 clean =>
 {
	 FILES => 'blib/* Makefile MANIFEST CGI-Snapp-Plugin-Redirect-*'
 },
 dist =>
 {
	 COMPRESS => 'gzip',
	 SUFFIX   => 'gz'
 },
 DISTNAME  => 'CGI-Snapp-Plugin-Redirect',
 NAME      => 'CGI::Snapp::Plugin::Redirect',
 PL_FILES  => {},
 PREREQ_PM =>
 {
	 CGI        => 3.59,
	 CGI::Snapp => 1.00,
	 Exporter   => 5.567,
	 parent     => 0,
	 strict     => 1.03,
 	 Test::More => 0.94,
 	 Test::Pod  => 1.44,
	 vars       => 1.01,
	 warnings   => 1.03,
 },
 VERSION_FROM => 'lib/CGI/Snapp/Plugin/Redirect.pm',
);
