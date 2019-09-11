class Api::V1::WeatherController <  Api::V1::BaseController
    
  def search
    @weather = WeatherTranslator.parse params[:city]
    render json: @weather.to_json, status: :ok
  end
end