# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  before { host! 'api.totalpass.v1' }

  let(:headers) do
    {
      'Accept' => 'application/vnd.totalpass.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'GET /api/v1/weather/search' do
    let(:city) { City.create(name: 'Rio de Janeiro', uf: 'SP') }

    before do
      get "/api/v1/weather/search?city=#{city.name}", params: {}.to_json, headers: headers
    end

    context 'when the call are correct' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json data weather' do
        expect(json_body[:table][:city]).to eq(city.name)
      end
    end
  end

  describe 'GET /api/v1/weather/search' do
    let(:city) { City.create(name: 'sfrwegbregiu', uf: 'SP') }

    before do
      get "/api/v1/weather/search?city=#{city.name}", params: { }.to_json, headers: headers
    end

    context 'when the call with parameter is incorrect' do
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
