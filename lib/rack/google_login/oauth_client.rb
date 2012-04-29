require 'rack/oauth2'
require 'httpclient'

class Rack::OAuth2::Client::Google < Rack::OAuth2::Client

  def initialize(attributes = {})
    super(attributes.merge(
      :authorization_endpoint => 'https://accounts.google.com/o/oauth2/auth',
      :token_endpoint         => 'https://accounts.google.com/o/oauth2/token',
      :host                   => 'accounts.google.com'))
  end

  def authorization_uri
    super(:response_type => :code,
          :scope         => ['https://www.googleapis.com/auth/userinfo.profile',
                             'https://www.googleapis.com/auth/userinfo.email'])
  end

  def authorize! code
    self.authorization_code = code
    #TODO Rescue exception raises with invalid code
    @access_token = self.access_token! :not_basic_auth
  end


  def user_info
    #TODO memoize
    c = HTTPClient.new
    #TODO Rescue JSON parse error and HTTP error
    JSON.parse \
      c.get_content('https://www.googleapis.com/oauth2/v1/userinfo',
                    :access_token => @access_token.access_token)
  end

end
