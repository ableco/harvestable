module Harvestable
  class ResponseMiddleware < Her::Middleware::ParseJSON
    def parse(body)
      json = parse_json(body)

      _collection_key, collection_data = json.find { |_, v| v.is_a?(Array) }

      data = json[:id] ? json : collection_data || json

      {
        data: data,
        errors: json[:errors] || [],
        metadata: json[:metadata]
      }
    end

    def on_complete(env)
      env[:body] = env[:status] == 204 ? parse("{}") : parse(env[:body])
    end
  end
end
