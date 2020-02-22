Rails.application.routes.draw do
  root to: 'tweets#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get 'logout'
    end
  end

end
