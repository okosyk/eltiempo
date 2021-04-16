module Eltiempo
  class TemperatureDataPresenter
    def self.todays_temperature(city:, min: , max:)
      puts "Today in #{city}, minimal temperature is #{min}, and maximum is #{max}."
    end

    def self.minimum_average(city:, value:)
      puts "Average minimum temperature in #{city} during next week is #{value.round(1)}"
    end

    def self.maximum_average(city:, value:)
      puts "Average maximum temperature in #{city} during next week is #{value.round(1)}"
    end
  end
end