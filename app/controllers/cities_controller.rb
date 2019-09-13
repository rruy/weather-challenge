# frozen_string_literal: true

class CitiesController < ApplicationController
    
  def search
    @cities = City.where('name LIKE ?', "%#{params[:q]}%")
    render json: @cities
  end
  
end
  