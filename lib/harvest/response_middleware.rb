module Harvest
  class ResponseMiddleware < Her::Middleware::ParseJSON
    def parse(body)
      json = parse_json(body)

      collection_key, collection_data = json.find{|_, v| v.is_a?(Array)}
      data =
        if json[:id]
          json
        else
          collection_data || json
        end

      {
        :data => data,
        :errors => json[:errors],
        :metadata => json[:metadata]
      }
    end

    def on_complete(env)
      env[:body] = case env[:status]
                   when 204
                     parse('{}')
                   else
                     parse(env[:body])
                   end
    end
  end
end
