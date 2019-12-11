Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # root 'home#index'
  root 'issues#index'
  get 'home', to: 'home#index'
  
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :users, only: %i[new show create update destroy] do
    collection do
      get 'edit'
    end
  end

  # resources :issues, only: [:index]
  resources :issues
  resources :products do
  # resources :products, param: :name do
    resources :issues
  end

  resources :issue_comments do
    patch  :toggle_like, to: 'toggle_like'
  end

  namespace :setting do
    # get :system
    get '/', to: '/setting#index'

    namespace :products do
      get   :index,         to: '/products#index'
      get   :edit_all,      to: '/products#edit_all'
      post  :update_all,    to: '/products#update_all'
      post  :add_new_row,   to: '/products#add_new_row'
    end

    namespace :issue_type do
      get   :index,         to: '/issue_type#index'
      get   :edit_all,      to: '/issue_type#edit_all'
      post  :update_all,    to: '/issue_type#update_all'
      post  :add_new_row,   to: '/issue_type#add_new_row'
      get   :ajax_test,     to: '/issue_type#ajax_test'
    end
  end

end
