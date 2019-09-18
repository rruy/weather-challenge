# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    binding.pry
    city = params[:city]
    @weather = ForecastService.call(city)
  rescue => e
    head 500
  end

end
