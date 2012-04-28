# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-google_login"
  s.version     = '0.0.1'
  s.authors     = ["Fujimura Daisuke"]
  s.email       = ["me@fujimuradaisuke.com"]
  s.homepage    = "https://github.com/fujimura/rack-google_login"
  s.description = %q{Minimalist login for rack app with Google account}
  s.summary     = %q{Minimalist login for rack app with Google account}

  s.rubyforge_project = "rack-google_login"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "rack",        '>= 1.4.1'
  s.add_dependency "sinatra",     '>= 1.3.2'
  s.add_dependency "httpclient",  '>= 2.2.4'
  s.add_dependency "rack-oauth2", '>= 0.11.0'
  s.add_development_dependency "rake",      '>= 0.9.2.2'
  s.add_development_dependency "rack-test", '>= 0.6.1'
  s.add_development_dependency "rspec",     '>= 2.8.0'
  s.add_development_dependency "webmock",   '>= 1.8.6'
  s.add_development_dependency "pry"
end
