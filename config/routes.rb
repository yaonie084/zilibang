Zilibang::Application.routes.draw do

  get "home/index"

  root :to => "home#index"
  resource :user_session
  match "login" => "user_sessions#new", :as => :login
  match "register_check_instructions/:id" => "users#register_check_instructions", :as => :register_check_instructions
  match 'logout' => "user_sessions#destroy", :as => :logout
  get 'buyer_sure/:id' => "comments#buyer_sure", :as => :buyer_sure
  get 'buyer_cancel/:id' => "comments#buyer_cancel",  :as => :buyer_cancel
  get 'employer_sure/:id' => "comments#employer_sure", :as => :employer_sure
  get 'employer_cancel/:id' => "comments#employer_cancel",  :as => :employer_cancel
  get 'overpost/:id' => "posts#over", :as => :over_post
  get 'finish/:id' => "posts#finish", :as => :finish_post
  get 'pay_sure/:id' => "home#pay_sure", :as => :pay_sure_post
  get 'pay/:id' => "home#pay", :as => :pay_post
  post 'report_employer' => "comments#report_employer", :as => :report_employer
  post 'report_buyer' => "comments#report_buyer", :as => :report_buyer
  post 'verify' => "comments#verify_code", :as => :verify_code
  get 'mailer' => "home#mailer", :as => :mailer

  get 'forgot_password' => "users#forgot_password", :as => :forgot_password
  post 'forgot_password_sender' => "users#forgot_password_sender", :as => :forgot_password_sender
  get 'forgot_check_instructions/:id' => "users#forgot_check_instructions", :as => :forgot_check_instructions
  put 'update_user' => "users#update", :as => :update_user

  
  resources :users, :only => [:new, :create]
  resources :profiles, :only => [:show]
  resources :posts do
    post 'add_comment'
  end

  namespace :admin do
    get 'main/index'
    root :to => "main#index"
    resources :posts, :except => [:destroy]
    post 'posts/:id/destroy' => "posts#destroy", :as => :destroy_post
    resources :users do
      collection do
        get "change_password"
        put "update_password"
      end
    end
    post 'tags/:id/destroy' => "tags#destroy", :as => :destroy_tag
    resources :tags, :only => [:index, :new, :create]
    
  end

  namespace :center do
    root :to => "main#index"
    #resources :profiles, :only => [:show, :edit, :update]
    get 'profile' => 'profiles#show', :as => :profile
    get 'profile/edit' => 'profiles#edit', :as => :edit_profile
    put 'profile' => 'profiles#update', :as => :update_profile
    get 'messages' => 'messages#index', :as => :messages
    get 'message/show/:name' => 'messages#show',  :as => :show_message
    get 'messages/new' => 'messages#new', :as => :new_message
    post 'messages' => 'messages#create'
    post 'messages/:id/destroy' =>  'messages#destroy',  :as => :destroy_message
  end

end
