Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
}


  resources :signup do


    collection do
      get 'index'
      get 'mem'
      get 'sms'
      get 'done' # 登録完了後のページ
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'items#index'
  resources :items

  resources :users, only: [:show] do
    collection do
      get 'logout'
    end
  end

end
