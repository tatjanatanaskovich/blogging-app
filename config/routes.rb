Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  resources :blogs do
    member do
      get :change_blog_status
    end
  end

  root to: 'blogs#index'
end
