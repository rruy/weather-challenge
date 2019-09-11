
class DashboardController < ApplicationController
  
  def index
    search_weather
  end

  def search
    search_weather
    render 'index'
  end

  private 

  def search_weather
    city = (params[:city].blank? ? "Sao Paulo" : params[:city])
    @weather = Openweather2.get_weather(city: "#{city},BR", units: 'imperial')
    @weather = WeatherTranslator.parse @weather
  end

end
