module Eltiempo
  module TiempoService
    module Api
      class Cities < Base
        BASE_URL = "https://www.tiempo.com/peticionBuscador.php".freeze

        def self.get_cities_list(query)
          params = {
            lang: :es,
            texto: query
          }

          response = Eltiempo::HttpService.new(url: BASE_URL, headers: headers, params: params).get
          JSON.parse(response.body)
        end
      end
    end
  end
end