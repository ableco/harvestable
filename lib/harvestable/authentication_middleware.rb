module Harvestable
  class AuthenticationMiddleware < Faraday::Middleware
    AUTH_HEADER = "Authorization".freeze unless defined? AUTH_HEADER
    HARVEST_HEADER = "Harvest-Account-Id".freeze unless defined? HARVEST_HEADER

    def initialize(app, access_token, account_id)
      @access_token = access_token
      @account_id = account_id
      super(app)
    end

    def call(env)
      env.request_headers[AUTH_HEADER] = "Bearer #{@access_token}" unless env.request_headers[AUTH_HEADER]
      env.request_headers[HARVEST_HEADER] = @account_id unless env.request_headers[HARVEST_HEADER]
      @app.call(env)
    end
  end
end
