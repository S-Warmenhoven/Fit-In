Rails.application.routes.draw do
  
  resources :social_events
  resources :trainers
  resources :class_schedules

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  get "prepare" => "home#prepare"

  get "contact_us" => "home#contact_us"

  get "cafe" => "home#cafe"

  resources :users do
    resources :user_workouts
    resources :user_meals
  end
  resource :session, only: [:new, :create, :destroy]

  resources :workouts do
    resources :user_workouts

    #resources :user_workouts do
      # put :approving
      # put :rejecting
    #end
  end

  resources :user_workouts

  resources :food_items do
    get "order_by_price" => "user_meals#order_by_price"
    get "order_by_meal_count" => "user_meals#order_by_meal"
  end

  resources :user_meals


end
