use Module::Build;

Module::Build -> new
(
 module_name    => 'CGI::Snapp::Plugin::Redirect',
 license        => 'artistic',
 dist_abstract  => 'A plugin for CGI::Snapp to simplify using HTTP redirects',
 dist_author    => 'Ron Savage <ron@savage.net.au>',
 build_requires =>
 {
 	 Test::More => 0.94,
 	 Test::Pod  => 1.44,
 },
 configure_requires =>
 {
 	 Module::Build => 0.3800,
 },
 requires =>
 {
	 CGI        => 3.59,
	 CGI::Snapp => 1.00,
	 Exporter   => 5.567,
	 parent     => 0,
	 strict     => 1.03,
	 vars       => 1.01,
	 warnings   => 1.03,
 },
) -> create_build_script();
