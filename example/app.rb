require 'bundler/setup'
require 'sinatra'
enable :inline_templates

before do
  if session['user_info'].nil? && request.path != '/login'
    session['return_to'] = request.path
    redirect '/login'
  end
end

get '/' do
  erb :index
end

get '/foo' do
  erb :foo
end

get '/login' do
  %Q|<a href="#{Rack::GoogleLogin.authorization_uri}">Please login</a>|
end

get '/logout' do
  session['user_info'] = nil
  redirect '/'
end

=begin

Rack::GoogleLogin catches request to /callback.
It authorizes code, get user_info, set it to session, and redirect to root.
if return_to was set in session, will be back to there.

=end

__END__

@@ index
<html>
  <body>
    <% session['user_info'].each do |key, value| %>
      <dl>
        <dt><%= key %></dt>
        <dd><%= value %></dd>
      </dl>
    <% end %>
    <p>
      <a href='/logout'>Logout</a>
    </p>
  </body>
</html>

@@ foo
<html>
  <body>
    <h1>Bar</h1>
    <p>
      <a href='/'>back</a>
    </p>
  </body>
</html>
