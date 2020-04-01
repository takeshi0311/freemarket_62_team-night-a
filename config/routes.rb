Rails.application.routes.draw do

  devise_for :users
  

  resources :signup, only: [:index, :create], path: "/signup" do
    collection do
      get 'index'
      get 'member'
      get 'sms'
      get 'done', to: 'signup#create' # 入力した情報すべてを保存
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :pays, only:[:new,:create,:show,:destroy] do
    collection do
      post 'register', to: 'pays#register'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'pay'
      get 'buy'
    end
  end
  
  root to: 'items#index'
  resources :items do
    resources :favorites, only: [:create,:destroy]
      resources :comments, only: [:create]
  #Ajaxで動くアクションのルートを作成
  collection do
    get 'category_children', defaults: { format: 'json' }
    get 'category_grandchildren', defaults: { format: 'json' }
    get 'price', defaults: { format: 'json' }
    get 'image_destroy', defaults: { format: 'json' }
    get 'search'
    end
  end

  resources :users do
    collection do
      post 'register', to: 'users#register'
      get 'mypage'
      get 'logout'
      get 'address'
    end
  end

  resources :categories, only: [:index]
end
