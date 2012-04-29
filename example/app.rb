require 'bundler/setup'
require 'sinatra'
enable :inline_templates

before do
  if session['user_info'].nil? && request.path != '/login'
    redirect '/login'
  end
end

get '/' do
  erb :index
end

get '/login' do
  %Q|<a href="#{Rack::GoogleLogin.authorization_uri}">Please login</a>|
end

get '/logout' do
  session['user_info'] = nil
  redirect '/'
end

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
