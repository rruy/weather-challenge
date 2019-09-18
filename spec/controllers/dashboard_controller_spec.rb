# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    let(:params) do
      { city: 'Rio de Janeiro' }
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(302)
    end

    context "search forecast successful" do
      before do
        allow(ForecastService).to receive(:new) {
          -> { true }
        }
      end

      it "returns a correct status code" do
        post :index, params: params
        expect(response.status).to eq 302
      end
    end

    context "call Forecast failed" do
      let(:params) do
        { city: nil }
      end

      before do
        allow(ForecastService).to receive(:new) {
          -> { false }
        }
      end

      it "returns a correct status code" do
        post :index, params: params
        expect(response.status).to eq 302
      end
    end
  end
end
