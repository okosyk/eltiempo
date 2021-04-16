module Eltiempo
  class ForecastSerializer
    attr_reader :xml

    MAXIMUM_TEMPERATURE_SECTION_LABEL = "Maximum Temperature".freeze
    MINIMUM_TEMPERATURE_SECTION_LABEL = "Minimum Temperature".freeze

    def initialize(xml: )
      @xml = xml
    end

    def todays_max
      section(MAXIMUM_TEMPERATURE_SECTION_LABEL)[0]["value"]
    end

    def todays_min
      section(MINIMUM_TEMPERATURE_SECTION_LABEL)[0]["value"]
    end

    def average_max
      data = section(MAXIMUM_TEMPERATURE_SECTION_LABEL)

      return 0 if data.count.zero?
      data.map {|forecast| forecast["value"].to_f }.sum / data.count
    end

    def average_min
      data = section(MINIMUM_TEMPERATURE_SECTION_LABEL)

      return 0 if data.count.zero?
      data.map {|forecast| forecast["value"].to_f }.sum / data.count
    end

    private

      def doc
        @doc ||= Nokogiri::XML(xml)
      end

      def section(label)
        doc.xpath("//location/var[name = '#{label}']/data/forecast")
      end
  end
end
