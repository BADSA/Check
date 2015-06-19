Rails.application.routes.draw do

  resources :question_answers

  resources :test_answers

  resources :questions

  resources :tests

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  devise_scope :user do
    get 'users/post_status' , to: 'users/registrations#post_status',:as => "user_posts_status"
  end

  root 'pages#index'
  get 'tests/:id/score', to:'tests#score'

end
