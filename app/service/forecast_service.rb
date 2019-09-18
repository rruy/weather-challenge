class ForecastService
    attr_reader :city

    def initialize(city)
      @city = city
    end

    def self.call(city)
      new(city).call
    end

    def call
      city = (@city.blank? ? "Sao Paulo" : @city)
      data = Openweather2.get_weather(city: "#{city},BR", units: 'imperial')
      OpenStruct.new fill(data)
    end

    private

    def fill data
      { 
        city: data.city,
        longitude: data.longitude,
        latitude: data.latitude,
        temperature: { 
            celsius: convert_temp(data),
            fareinaitew: data.temperature
        },
        pressure: data.pressure,
        humidity: data.humidity,
        min_temperature: data.min_temperature,
        max_temperature: data.max_temperature,
        clouds: data.clouds,
        wind_speed: data.wind_speed,
        wind_angle: data.wind_angle
      }
    end
    
    def convert_temp data
      celsius = ((data.temperature.to_f - 32) * 5 / 9).to_i
    end

end

