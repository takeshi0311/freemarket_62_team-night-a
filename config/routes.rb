Rails.application.routes.draw do
  get 'purchase/index'

  get 'purchase/done'

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
  resources :pays, only:[:new,:create,:show] do
    collection do
      post 'show', to:'pays#show'
      post 'register', to: 'pays#register'
      post 'delete', to: 'pays#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
end
