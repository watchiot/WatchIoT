Rails.application.routes.draw do

  get     'register'  => 'users#register',  :as => 'register'
  get     'login'     => 'users#login',     :as => 'login'
  post    'login'     => 'users#do_login',  :as => 'do_login'
  get     'logout'    => 'users#logout',    :as => 'logout'
  get     'download'  => 'download#index',  :as => 'download'
  post    'contact'   => 'home#contact',    :as => 'home/contact'
  get     'home'      => 'home#index',      :as => 'home/index'

  get     '/:username',                                 controller: 'dashboard', action:  'show'

  #chart route
  get '/:username/chart',                               controller: 'chart', :action => 'show'

  #setting route
  get     '/:username/setting',                         controller: 'setting', :action => 'show'
  patch   '/:username/setting/profile',                 controller: 'setting', :action => 'profile'
  patch   '/:username/setting/account/email/add',       controller: 'setting', :action => 'account_email_add'
  delete  '/:username/setting/account/email/delete',    controller: 'setting', :action => 'account_email_delete'
  patch   '/:username/setting/account/email/principal', controller: 'setting', :action => 'account_email_principal'
  patch   '/:username/setting/account/chpassword',      controller: 'setting', :action => 'account_ch_password'
  patch   '/:username/setting/account/chusername',      controller: 'setting', :action => 'account_ch_username'
  delete  '/:username/setting/account/delete',          controller: 'setting', :action => 'account_delete'
  patch   '/:username/setting/plan/upgrade',            controller: 'setting', :action => 'plan_upgrade'
  patch   '/:username/setting/team/add',                controller: 'setting', :action => 'team_add'
  delete  '/:username/setting/team/delete',             controller: 'setting', :action => 'team_delete'
  patch   '/:username/setting/team/permission',         controller: 'setting', :action => 'team_permission'
  patch   '/:username/setting/key/generate',            controller: 'setting', :action => 'key_generate'

  #spaces route
  post    '/:username/create',                          controller: 'spaces', :action => 'create'
  get     '/:username/spaces',                          controller: 'spaces', :action => 'index'
  patch   '/:username/:spacename',                      controller: 'spaces', :action => 'edit'
  get     '/:username/:spacename/setting',              controller: 'spaces', :action => 'setting'
  get     '/:username/:spacename/delete',               controller: 'spaces', :action => 'delete'
  get     '/:username/:spacename',                      controller: 'spaces', :action => 'show'

  #projects route
  post    '/:username/:spacename/create',               controller: 'spaces', :action => 'create'
  get     '/:username/:spacename/projects',             controller: 'projects', :action => 'index'
  patch   '/:username/:spacename/:projectname',         controller: 'projects', :action => 'edit'
  get     '/:username/:spacename/:projectname/setting', controller: 'projects', :action => 'setting'
  get     '/:username/:spacename/:projectname/delete',  controller:'projects', :action => 'delete'
  get     '/:username/:spacename/:projectname',         controller: 'projects', :action => 'show'

  root    'home#index'

  # at the end of you routes.rb
  get     '*a', to:  'errors#routing'

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
