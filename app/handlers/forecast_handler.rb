module Eltiempo
  class ForecastHandler
    attr_reader :action, :city_name

    VALID_ACTIONS = %w(today av_max av_min).freeze

    def initialize(action:, city_name:)
      @action = action
      @city_name = city_name
    end

    def process
      validate_data

      # serilize xml data fetched from forecast service
      serializer = Eltiempo::ForecastSerializer.new(xml: forecast)

      case action
        when "today" then Eltiempo::TemperatureDataPresenter.todays_temperature(city: actual_city_name, min: serializer.todays_min, max: serializer.todays_max)
        when "av_max" then Eltiempo::TemperatureDataPresenter.maximum_average(city: actual_city_name, value: serializer.average_max)
        when "av_min" then Eltiempo::TemperatureDataPresenter.minimum_average(city: actual_city_name, value: serializer.average_min)
      end
    end

    private

      def validate_data
        # validate action
        raise Eltiempo::UnknownActionError.new unless action_valid?

        # city id should be present
        raise Eltiempo::CityNotFoundError.new if found_city.nil?
      end 

      def forecast
        client.weather.get_forecast(city_id)
      end

      def city_id
        found_city["id"]
      end

      def actual_city_name
        found_city["nombre"]
      end

      def found_city
        @found_city ||= client.cities.get_cities_list(city_name)["localidad"].first
      end

      def client
        @client ||= Eltiempo::TiempoService::Client.new
      end

      def action_valid?
        VALID_ACTIONS.include?(action)
      end
  end
end