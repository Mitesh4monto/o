Opp::Application.routes.draw do
   
  # messages (contact us)
  get "messages_controller/new"
  get "messages_controller/create"

  resources :activity_sequences
  resources :activity_in_sequences

  mount Ckeditor::Engine => '/ckeditor'


  # hals
  get "hals/view(/:tab)", to: 'hals#view', as: 'view_hals'
  get "hals/view/1", to: 'hals#view', as: 'hals_my_insights'
  get "hals/view/2", to: 'hals#view', as: 'hals_following'
  get "hals/view/3", to: 'hals#view', as: 'hals_my_courses'
  get "hals/view/4", to: 'hals#view', as: 'hals_all_hals'
  get "hals/view/5", to: 'hals#view', as: 'hals_help_wanted'
  get "hals/view/0", to: 'hals#view', as: 'hals_mine'
  
  get "courses/:id/4", to: 'courses#show', as: 'course_people'
  get "hals/edit/:id", to: 'hals#edit', as: 'edit_hal'
  # get "hals/hal_about_activity/:id", to: 'hals#hal_about_activity', as: 'hal_about_activity'
  get "hals/new_hal(/:id)", to: 'hals#new_hal', as: 'new_hal'

  resources :hals
  
  
  # activities and strategies
  resources :activities, :collection => { :sort => :post }
  # resources :activity_in_sequences, :collection => { :sort => :post }
  get "activity_sequences/sort", to: "activity_sequences#sort", as: 'sort_activity_sequences'

  get "activities/sort", to: "activities#sort", as: 'sort_activities'
  get "activities/show/:id", to: "activities#show", as: 'show_activity'
  get "activities/new", to: "activities#new",  as: 'add_activity'
  get "activity_in_sequences/add_to_sequence/:id", to: "activity_in_sequences#add_to_sequence",  as: 'add_activity_to_sequence'
  
  get "activities/add_activity_to_course/:id", to: "activities#add_activity_to_course",  as: 'add_activity_to_course'
  get "activities/edit_activity_in_course/:id", to: "activities#edit_activity_in_course",  as: 'edit_activity_in_course'
  
  post "activities/create_activity_in_course/:id", to: "activities#create_activity_in_course",  as: 'create_activity_in_course'
  get "strategies/copy_activity/:id", to: "strategies#copy_activity",  as: 'copy_activity'

  get "activities/mine", to: "strategies#mine",  as: 'user_strategy'
  get "strategies/mine?tut=true", to: 'strategies#mine', as: 'tut'  
  get "strategies/mine(/:id)", to: 'strategies#mine', as: 'myp'
  get "strategies/mine_details/:id", to: 'strategies#mine_details', as: 'mypd'

  get "commitment_marks", to: 'commitment_marks#mycms', as: 'mycms'


  # courses
  get "courses/new", to: 'courses#new', as: 'create_course'
  get "courses/my_created", to: 'courses#my_created', as: 'my_created_courses'
  get "courses/new", to: 'courses#new', as: 'create_course'
  get "courses/my_created", to: 'courses#my_created', as: 'my_created_courses'
  get "courses/update_description/:id", to: 'courses#update_description', as: 'update_description'
  get "courses/publish_course/:id", to: 'courses#publish_course', as: 'publish_course'
  get "courses/edit_course/:id(/:tab)/(:actvitiy_id)", to: 'courses#edit_course', as: "edit_course"
  get "courses/edit_course/:id/0", to: 'courses#overview_edit', as: 'course_overview_edit'
  get "courses/edit_course/:id/1/(:actvitiy_id)", to: 'courses#edit_course', as: 'course_plan_edit'
  get "courses/edit_course/:id/2", to: 'courses#description_edit', as: 'course_description_edit'
  get "courses/:id(/:tab)", to: 'courses#show', as: 'show_course'
  get "courses/:id/4", to: 'courses#show', as: 'course_people'
  get "courses/:id/3", to: 'courses#show', as: 'course_blogs'
  get "courses/:id/2", to: 'courses#show', as: 'course_description'
  get "courses/:id/1", to: 'courses#show', as: 'course_plan'
  get "courses/:id/0", to: 'courses#show', as: 'course_overview'
  resources :courses
  

  match "share_course_on_fb/:id", to: "courses#share_course_on_fb", as: "share_course_on_fb"

  # static pages
  get "banner", to: 'info#banner', as: 'bann'
  get "about_us", to: 'info#about', as: 'about'
  get "eula", to: 'info#eula', as: 'eula'
  get "privacy", to: 'info#privacy', as: 'privacy'
  get "howitworks", to: 'info#howitworks', as: 'howitworks'
  get "gettingstartedcreate", to: 'info#gettingstartedcreate', as: 'gettingstartedcreate'
  get "gettingstartedoverview", to: 'info#gettingstartedoverview', as: 'gettingstartedoverview'

  get "contact_us", to: 'messages#new', as: 'contact_us'
  match "newsletter", to: 'messages#news', as: 'newsletter'
  resources :messages

  match "add_commitment_mark_to_activity/:activity_id", :controller => "commitment_marks", :action => "add_commitment_mark_to_activity"

  match 'my_plan/:id',  :controller => "strategies", :action => "mine", :activity_id => :id

  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new", as: 'signin'
    get "sign_out", :to => "devise/sessions#destroy" #destroy_user_session"
  end  # devise_for :users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  match 'auth/:provider/callback', to: 'sessions#create'
  
  match 'auth/facebook/callback?error', to: redirect('/')
  match 'auth/facebook/callback?error_code', to: redirect('/')
  
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
    
  get 'users/follow_user/:id',:to => 'users#follow_user', as: 'follow'
  match 'users/login_or_signup',  :controller => "users", :action => "login_or_signup"
  match 'users/myprofile',  :controller => "users", :action => "myprofile", :as => "my_profile"
  match 'users/editmyprofile',  :controller => "users", :action => "edit_profile", :as => "edit_profile"


  resources :users do
    member do
      put :follow
      put :unfollow
    end
  end
  # match 'followuser/:id',  :controller => "users", :action => "follow"
  # put "users/follow", to: 'users#follow', as: 'follow_user'
  
  
  resources :comments

  match 'join_course/:id',  :controller => "courses", :action => "join", :as => "join_course"

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
