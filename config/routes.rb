Rails.application.routes.draw do

  resources :blogs do
    member do
      get :change_blog_status
    end
  end

  root to: 'blogs#index'
end
