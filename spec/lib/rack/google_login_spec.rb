require 'spec_helper'
require 'rack/test'

describe Rack::GoogleLogin do
  include Rack::Test::Methods

  let(:app) do
    Rack::GoogleLogin.new do |app|
      app.config['session_secret'] = "1022a2c8c9a7424b961c6563ca7a429e"
      app.config['identifier']     = '593253034687.apps.googleusercontent.com'
      app.config['secret']         = 'TsC26xQXyruOP1bINYE5N9Ou'
      app.config['redirect_uri']   = 'http://localhost:3000/'
    end
  end

  #FIXME seems to be mocking too hard
  mock_session! Rack::GoogleLogin
  let!(:oauth_client) { double }
  before do
    Rack::GoogleLogin.any_instance.stub(:oauth_client).and_return oauth_client
  end

  describe 'GET /callback' do
    let(:code) { 'some code' }
    let(:user_info) { { 'email' => 'abc@def.com' } }
    before do
      oauth_client.stub(:authorize!).with code
      oauth_client.stub(:user_info).and_return user_info
    end
    it 'should set user_info from google to session' do
      get '/callback', 'code' => code
      session['user_info'].should == user_info
    end
    context 'if return_to was set to /somewhere' do
      it 'should redirect to /somehere' do
        session['return_to'] = '/somewhere'
        get '/callback', 'code' => code
        should redirect_to url_for '/somewhere'
      end
    end
    context 'if return_to was not set to session' do
      it 'should redirect to /' do
        session[:return_to].should == nil
        get '/callback', 'code' => code
        should redirect_to url_for '/'
      end
    end
  end
end
