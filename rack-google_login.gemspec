# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/google_login/version"

Gem::Specification.new do |s|
  s.name        = "rack-google_login"
  s.version     = Rack::GoogleLogin::VERSION
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
  # TODO Specify version
  s.add_dependency "rack"
  s.add_dependency "sinatra"
  s.add_dependency "httpclient"
  s.add_dependency "rack-oauth2"
  s.add_development_dependency "rake"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
  s.add_development_dependency "pry"
end
