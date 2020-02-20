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
  resources :pays, only:[:new,:show] do
    collection do
      post 'show', to: 'pay#show'
      post 'purchase', to: 'pay#purchase'
      post 'delete', to: 'pay#delete'
    end
  end
end
