$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'google_login/oauth_client'

module Rack
  class GoogleLogin < Sinatra::Base

    @@config = {}

    def initialize(app = nil)
      super
      self.class.use Rack::Session::Cookie, secret: config['session_secret']
      self.class.enable :sessions
    end


    get '/login' do
      %Q|<a href="#{oauth_client.authorization_uri}">Please login</a>|
    end

    get '/logout' do
      session['user_info'] = nil
      redirect '/'
    end

    get '/callback' do
      oauth_client.authorize! params['code']
      session['user_info'] = oauth_client.user_info
      redirect (session.delete(:return_to) || '/')
    end

    def oauth_client
      @_c ||= Rack::OAuth2::Client::Google.new(
        :identifier   => config['identifier'],
        :secret       => config['secret'],
        :redirect_uri => config['redirect_uri'])
    end

    def config
      self.class.config
    end

    def config= conf
      self.class.config = conf
    end

    def self.config
      @@config
    end

    def self.config= conf
      @@config = conf
    end

  end
end
