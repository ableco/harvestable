require "her"

require "harvest/version"
require "harvest/authentication_middleware"
require "harvest/response_middleware"

module Harvest
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
      self.configuration.setup_connection
    end
  end

  class Configuration
    attr_accessor :auth_token, :ssl_options, :send_only_modified_attributes, :base_url, :access_token, :account_id, :user_agent
    attr_reader :connection

    def initialize
      @send_only_modified_attributes = false
      @ssl_options = {}
      @proxy = nil
      @connection = Her::API.new
      @access_token = nil
      @account_id = nil
      @debug_responses = false
      @base_url = 'https://api.harvestapp.com/v2/'
      @user_agent = "Harvest Ruby client (v#{Harvest::VERSION})"
    end

    def setup_connection
      @connection.setup url: @base_url, ssl: @ssl_options, proxy: @proxy, send_only_modified_attributes: @send_only_modified_attributes do |c|
        # Authentication
        c.use Harvest::AuthenticationMiddleware, @access_token, @account_id

        # Response
        if ENV["DEBUG"] || @debug_responses
          c.use Faraday::Response::Logger, nil, { headers: true, bodies: true }
        end

        # Adapter
        c.use Faraday::Adapter::NetHttpPersistent
      end
    end
  end
end
