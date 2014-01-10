Opp::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  resources :activities

  get "hals/hal_about_activity/:id", to: "hals#hal_about_activity", as: 'hal_about_activity'
  get "hals/following", to: 'hals#following', as: 'following'

  get "hals/help_wanted", to: 'hals#help_wanted', as: 'help_wanted'
  get "hals/view_mine", to: 'hals#view_mine', as: 'my_hals'
  get "hals/hal_about_activity/:id", to: 'hals#hal_about_activity', as: 'hal_about_activity'
  get "hals/new_hal", to: 'hals#new_hal', as: 'new_hal'
  
  get "activities/new", to: "activities#new",  as: 'add_activity'
  get "activities/add_activity_to_course/:id", to: "activities#add_activity_to_course",  as: 'add_activity_to_course'
  get "strategies/copy_activity/:id", to: "strategies#copy_activity",  as: 'copy_activity'

  get "strategies/mine", to: 'strategies#mine', as: 'myp'
  get "strategies/mine_details/:id", to: 'strategies#mine_details', as: 'mypd'

  get "courses/new", to: 'courses#new', as: 'create_course'
  get "courses/my_created", to: 'courses#my_created', as: 'my_created_courses'
  
  
  match "add_commitment_mark_to_activity/:activity_id", :controller => "commitment_marks", :action => "add_commitment_mark_to_activity"

  match 'my_plan/:id',  :controller => "strategies", :action => "mine", :activity_id => :id

  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy" #destroy_user_session"
  end  # devise_for :users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  match 'auth/:provider/callback', to: 'sessions#create'
  
  match 'auth/facebook/callback?error', to: redirect('/')
  match 'auth/facebook/callback?error_code', to: redirect('/')
  
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
    
  resources :contacts

  resources :courses
  resources :hals

  match 'users/myprofile',  :controller => "users", :action => "myprofile"
  match 'users/editmyprofile',  :controller => "users", :action => "edit_profile"


  resources :users do
    member do
      put :follow
      put :unfollow
    end
  end
  # match 'followuser/:id',  :controller => "users", :action => "follow"
  # put "users/follow", to: 'users#follow', as: 'follow_user'
  
  
  resources :comments

  match 'join_course/:id',  :controller => "courses", :action => "join"

  match 'co',  :controller => "courses", :action => "index"
  root :to => "home#index"
 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
  
  
  
end
