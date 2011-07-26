Zilibang::Application.routes.draw do

  get "home/index"

  root :to => "home#index"
  resource :user_session
  match "login" => "user_sessions#new", :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  get 'buyer_sure/:id' => "comments#buyer_sure", :as => :buyer_sure
  get 'employer_sure/:id' => "comments#employer_sure", :as => :employer_sure
  get 'overpost/:id' => "posts#over", :as => :over_post
  get 'pay/:id' => "home#pay", :as => :pay_post
  
  resources :users, :only => [:new, :create]
  resources :profiles, :only => [:new, :create, :show]
  resources :posts do
    post 'add_comment'
  end

  namespace :admin do
    resources :users do
      collection do
        get "change_password"
        put "update_password"
      end
    end
  end

end
