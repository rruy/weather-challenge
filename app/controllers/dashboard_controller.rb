# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @weather = search_weather
  end

  private

  def search_weather
    city = params[:city]
    @weather = WeatherTranslator.parse city
  end
end
