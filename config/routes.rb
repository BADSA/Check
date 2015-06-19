Rails.application.routes.draw do

  root 'pages#index'
  get 'test_answers/find', to:'test_answers#find'
  get 'test_answers/:id/save', to:'test_answers#save'
  get 'tests/:id/score', to:'tests#score'

  resources :question_answers

  resources :test_answers

  resources :questions

  resources :tests

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  devise_scope :user do
    get 'users/post_status' , to: 'users/registrations#post_status',:as => "user_posts_status"
  end

end
