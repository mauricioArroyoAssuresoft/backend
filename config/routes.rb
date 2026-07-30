Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :team_members, only: [:index, :create, :update]
    end
  end
end
