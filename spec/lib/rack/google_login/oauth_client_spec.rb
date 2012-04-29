require 'spec_helper'

describe Rack::OAuth2::Client::Google do
  subject do
    Rack::OAuth2::Client::Google.new(
      :identifier   => 'google_identifier',
      :secret       => 'google_secret',
      :redirect_uri => 'google_redirect_uri')
  end

  describe '#authorize' do
    it 'should set @access_token' do
      code = double
      access_token = double
      subject.should_receive(:authorization_code=).with code
      subject.should_receive(:access_token!).and_return access_token
      subject.authorize! code

      subject.instance_variable_get('@access_token').should == access_token
    end
  end
  describe '#user_info' do
    let(:user_info) { {'a' => 3} }
    let(:token_string) { 'oo-ave30djrt' }

    before do
      access_token = double
      access_token.stub(:access_token).and_return token_string
      subject.instance_variable_set '@access_token', access_token
      stub_request(:get, 'https://www.googleapis.com/oauth2/v1/userinfo').
        with(:query => {:access_token => token_string}).
        to_return(:body => user_info.to_json)
    end

    it 'should return user information in google' do
      subject.user_info.should == user_info
    end
    it 'should be memoize content' do
      subject.user_info
      HTTPClient.any_instance.should_not_receive :get_content
      subject.user_info
    end
  end
end
