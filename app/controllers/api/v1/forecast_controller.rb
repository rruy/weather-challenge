class Api::V1::ForecastController <  Api::V1::BaseController
  def search
    begin
      @weather = ForecastService.call(params[:city])
      render json: @weather.to_json, status: 200
    rescue => e
      render json: {}.to_json, status: 422
    end
  end
end