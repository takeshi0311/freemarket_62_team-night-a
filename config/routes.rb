Rails.application.routes.draw do
  get 'purchase/index'

  get 'purchase/done'

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
  root to: 'items#index'

  resources :pays, only:[:new,:create,:show] do
    collection do
      post 'show', to:'pays#show'
      post 'register', to: 'pays#register'
      post 'delete', to: 'pays#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      post 'index', to: 'purchase#index'
      get 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
      root to: 'items#index'
  
  resources :items do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'buy'
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'price', defaults: { format: 'json' }
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
