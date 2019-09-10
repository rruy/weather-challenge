
class DashboardController < ApplicationController
  
  def index
    @weather = Openweather2.get_weather(city: 'Sao Paulo,BR', units: 'imperial')
    @weather = WeatherTranslator.parse @weather
  end

end
