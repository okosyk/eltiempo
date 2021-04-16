module Eltiempo
  class HttpService
    attr_reader :url, :headers, :params, :path

    def initialize(url:, headers: {}, params: {})
      @url = url
      @path = URI.parse(url).path
      @headers = headers
      @params = params
    end

    [:post, :get].each do |http_verb|
      define_method(http_verb) do |data = {}|
        connection.send(http_verb, path, data)
      rescue Faraday::UnprocessableEntityError => e
        raise(Faraday::UnprocessableEntityError, e.response[:body])
      end
    end

    private

      def connection
        Faraday.new(url: url, headers: headers, params: params) do |conn|
          conn.use Faraday::Response::RaiseError
          conn.adapter Faraday.default_adapter
        end
      end
  end
end
