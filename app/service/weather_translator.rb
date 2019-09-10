class WeatherTranslator
  class << self 

    def parse data
        result = { 
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
        
        OpenStruct.new result
    end
        
    def convert_temp data
        celsius = ((data.temperature.to_f - 32) * 5 / 9).to_i
    end
  end
end