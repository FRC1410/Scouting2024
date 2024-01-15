Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :competitions

  resources :actions
  resources :matches do
    resources :match_actions do
      post :score_amp, on: :member
      post :score_trap, on: :member
      post :score_speaker, on: :member
      post :score_amp_auto, on: :member
      post :score_speaker_auto, on: :member
      post :score_trap, on: :member
      post :leave, on: :member
      post :toggle_auto, on: :member
    end

    resources :team_score_sheets do
      post :score_amp, on: :member
      post :score_trap, on: :member
      post :score_speaker, on: :member
      post :score_amp_auto, on: :member
      post :score_speaker_auto, on: :member
      post :score_trap, on: :member
      post :leave, on: :member
      post :toggle_auto, on: :member
    end
  end

  resources :alliances
  resources :teams
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "matches#index"
end
