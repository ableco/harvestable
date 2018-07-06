$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "harvest"

require "minitest/autorun"
require "json"

module StubRequests
  def stub_api_for(klass)
    klass.use_api (api = Her::API.new)

    api.setup url: "http://api.example.com" do |c|
      c.use Harvest::ResponseMiddleware
      c.adapter(:test) { |s| yield(s) }
    end
  end
end
