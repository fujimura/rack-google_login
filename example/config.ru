#!/usr/bin/env rackup

require 'bundler/setup'
require 'rack/google_login'
require './app'

map '/' do
  use Rack::GoogleLogin do |google_login|
    google_login.config = YAML.load_file 'config/config.yml'
  end
  run Sinatra::Application
end
