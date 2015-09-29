Rails.application.routes.draw do

  get 'register' => 'users#register', :as => 'register'
  get 'login' => 'users#login', :as => 'login'
  post 'login' => 'users#do_login', :as => 'do_login'
  get 'logout' => 'users#logout', :as => 'logout'
  get 'dashboard' => 'dashboard#index', :as => 'dashboard'
  get 'download' => 'download#index', :as => 'download'
  get 'about' => 'about#index', :as => 'about'
  get 'projects' => 'projects#index', :as => 'projects'
  get 'spaces' => 'spaces#index', :as => 'spaces'
  get 'chart' => 'chart#index', :as => 'chart'
  get 'setting' => 'setting#index', :as => 'setting'
  get 'spaces/setting' => 'spaces#setting', :as => 'spaces/setting'
  get 'projects/setting' => 'projects#setting', :as => 'projects/setting'

  resources :home
  resources :projects
  resources :spaces
  resources :chart
  resources :download
  resources :setting
  resources :about

  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
