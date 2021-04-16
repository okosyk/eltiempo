require "require_all"
require "pry"
require "faraday"
require "json"
require "nokogiri"

require_all "app"
require_all "config"

module Eltiempo
  action = ARGV[0].gsub(/[^a-z_ ]/i, '')
  city_name = ARGV[1]

  Eltiempo::ForecastHandler.new(action: action, city_name: city_name).process

  rescue Eltiempo::CityNotFoundError => e
    puts "Can't find city: #{city_name}"

  rescue Eltiempo::UnknownActionError => e
    puts "Action is not valid: #{action}"
    puts "Available actions is #{Eltiempo::ForecastHandler::VALID_ACTIONS}"
end