module Eltiempo
  module TiempoService
    module Api
      class Weather < Base
        BASE_URL = "http://api.tiempo.com/index.php"

        def self.get_forecast(location_id)
          params = {
              localidad: location_id,
              affiliate_id: Eltiempo::AFFILIATE_ID
          }

          response = Eltiempo::HttpService.new(url: BASE_URL, headers: headers, params: params).get
          response.body
        end
      end
    end
  end
end