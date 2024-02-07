Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index" 
  # Defines the root path route ("/")
  # root "articles#index"
  

  get "/home", to: "home#userprofile"
  get "home_suggest", to: "home#suggest"
  #get "home_follower", to: "home#suggest"
  resources :follows, only: :index
  get '/follows/:id/follow', to: "follows#follow", as: "follow_user"
  get '/follows/:id/unfollow', to: "follows#unfollow", as: "unfollow_user"
  get "home_follower", to: "home#follower", as: "home_follower"
  get "home_following", to: "home#following", as: "home_following"
  # get "home_casebtn", to: "home#casebtn", as: "home_casebtn"
  resources :home, only: :index do
    get 'casebtn'
  end
  get '/search1', to: "tweets#search1"
  resources :users
  resources :tweets do
    get 'retweeting'
    resources :likes do
      collection do
        get :check
      end
    end
  end
  # get "/tweets/:tweet_id/likes/check", to: "likes#check", on: :collection
  resources :comments
  post "/create_comment/:tweet_id", to: "comments#create_comment", as: :create_comment
  get "/tweet_feed", to: "tweets#feed", as: "tweet_feed" 
  get "/comment_page/:tweet_id/comments", to: "comments#comment_page", as: "comment_page"
  get "/retweet", to: "retweets#retweet", as: "retweet" 
  # get "/retweeting", to: "tweets#retweeting", as: "retweeting" 
  get "/subscription_plans", to: "subscriptions#subs_plans", as: "subscription_plans"
  get "/razorpay_p/:id", to: "subscriptions#razorpay_p", as: "razorpay_p"
  post '/subscription_v/:id',  to: 'subscriptions#subscription_v', as: "verify_subscription"
end
