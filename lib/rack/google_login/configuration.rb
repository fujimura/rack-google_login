module Rack
  class GoogleLogin < Sinatra::Base
    class Configuration < Hash
      class NotConfigured < StandardError; end
      def [] key
        raise NotConfigured.new(key) unless self.has_key? key
        self.fetch key
      end
    end
  end
end
