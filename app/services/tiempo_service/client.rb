module Eltiempo
  module TiempoService
    class Client
      def cities
        Eltiempo::TiempoService::Api::Cities
      end

      def weather
        Eltiempo::TiempoService::Api::Weather
      end
    end
  end
end