Rails.application.routes.draw do
  
  # users_controller
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # homes_controller
  root :to  => "homes#top"
  get "home/about" => "homes#about"
  
  # books_controller
  resources :books
  
 
  
end
