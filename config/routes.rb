Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
}
  root to: 'tweets#index'
  get 'tweets' => 'tweets#index'


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

end
