Rails.application.routes.draw do
  resources :social_events
  resources :trainers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  get "prepare" => "home#prepare"

  get "contact_us" => "home#contact_us"

  resources :class_schedules, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :index]

  resource :session, only: [:new, :create, :destroy]

  resources :workouts

  resources :social_events

  resources :user_workouts

end
