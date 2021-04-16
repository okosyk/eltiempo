module Eltiempo
  module TiempoService
    module Api
      class Base
        def self.headers
          {
            "Content-Type" => "application/json"
          }
        end
      end
    end
  end
end