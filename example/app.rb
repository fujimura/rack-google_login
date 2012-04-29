require 'bundler'
Bundler.require
require 'sinatra'
require 'haml'
enable :inline_templates

before do
  redirect '/login' unless session['user_info'] || request.path == '/login'
end

get '/' do
  haml :index
end

get '/login' do
  %Q|<a href="#{Rack::GoogleLogin.authorization_uri}">Please login</a>|
end

get '/logout' do
  session['user_info'] = nil
  redirect '/'
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
