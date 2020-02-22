Rails.application.routes.draw do
  root to: 'tweets#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'tweets#index'
  get 'tweets' => 'tweets#index'
  get 'users/loginid' => 'users#show'
  get "users/logout" => "users#logout"
end
