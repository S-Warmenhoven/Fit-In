Rails.application.routes.draw do
  
  resources :social_events
  resources :trainers
  resources :class_schedules

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  get "prepare" => "home#prepare"

  get "contact_us" => "home#contact_us"

  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :workouts do
    resources :user_workouts, shallow: true do
      put :approving
      put :rejecting
    end
  end

  resources :user_workouts


end
