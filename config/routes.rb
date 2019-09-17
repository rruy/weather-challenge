# frozen_string_literal: true

require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'
  post 'dashboard/index'
  
  resources :cities do
    collection do
      get 'search'
    end
  end

  root 'dashboard#index'

  namespace :api, defaults: { format: :json }, path: '/api/' do
    namespace :v1, path: '/v1', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      get 'forecast', to: 'forecast#search'
    end
  end
end
