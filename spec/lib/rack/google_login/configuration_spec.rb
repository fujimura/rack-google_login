require 'spec_helper'

describe Rack::GoogleLogin::Configuration do
  describe '#[]' do
    subject { Rack::GoogleLogin::Configuration.new }
    context 'if key was not found' do
      it 'should raise NotConfigured' do
        expect do
          subject['foo']
        end.to raise_error Rack::GoogleLogin::Configuration::NotConfigured
      end
    end
    context 'if key was found' do
      it 'should return key' do
        subject['bar'] = 'baz'
        subject['bar'].should == 'baz'
      end
    end
  end
end

