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
    city = params[:city]
    @weather = WeatherTranslator.parse city
  end

end
