require 'bundler'
Bundler.require
require 'sinatra'
require 'haml'
enable :inline_templates

before do
  redirect '/login' unless session['user_info']
end

get '/' do
  haml :index
end

__END__

@@ layout
%html
  = yield

@@ index
- session['user_info'].each do |key, value|
  %dl
    %dt= key
    %dd= value
%p
  %a{:href => '/logout'}Logout
