Bundler.require :default, :test
require File.expand_path File.join(File.dirname(__FILE__), '../lib/rack/google_login')
require 'rspec'
require 'webmock/rspec'

def url_for path
  "http://" + Rack::Test::DEFAULT_HOST + path
end

def mock_session!(app)
  let!(:session) { Hash.new }
  before do
    app.any_instance.stub(:session).and_return session
  end
end

RSpec::Matchers.define :redirect_to do |expected_path|
  @expected_path = expected_path
  match do
    @actual_path = URI.parse(last_response.header['Location']).path

    next false unless @actual_path

    case @expected_path
    when Regexp
      @actual_path =~ expected_path
    when String
      @actual_path == expected_path
    else
      raise
    end
  end

  description do
    "redirect to #{@actual_path}"
  end

  failure_message_for_should do |model|
    "expected to be redirected to #{@expected_path} but #{@actual_path}"
  end
end
