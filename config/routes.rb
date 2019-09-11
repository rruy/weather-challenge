require 'api_version_constraint'

Rails.application.routes.draw do
  get 'dashboard/index'
  post 'dashboard/search'
  get 'dashboard/search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'

  namespace :api, defaults: { format: :json }, path: '/api/'  do
    namespace :v1, path: '/v1', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :weather do
        collection do
          get 'search'
        end
      end
    end
  end
end
