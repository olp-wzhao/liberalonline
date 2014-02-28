V44::Application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations", 
    omniauth_callbacks: "users/omniauth_callbacks",
    invitations: 'invitations'
  }

  get "party_history/index"

  resources :lawnsign_requests
  resources :volunteers
  resources :photos
  resources :videos
  resources :enewsletters
  resources :tasks
  resources :events

  get "validate_user" => "users#validate"

  get "create_account" => "users#edit"

  get "find_riding" => "riding_addresses#index"

  # devise_for :admins
  #
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index"
  end


  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'
  
  get "partyhistory" => "party_history#index"
  get "constitution/index" => "constitution#index"
  get "constitution/show" => "constitution#show"
  get "constitution/:id" => "constitution#show"
  get "my_liberal/index"
  #get "profile/index"
  #get "register/index"
  #get "login/index"
  get "volunteer_extended_profile/index"
  get "volunteer_extended_profile/show"
  get "donation_limits/index"
  get "logo/index"
  get "abc_member/index"
  #get "contact/index"
  get "candidates/index"
  #get "fb_test/index"
  #get "fb_test/show"
  get "redtrillium/index"
  get "ontarioliberalfund/index"
  get "eligibility/index"
  get "getinvolved/index"
  get "aboutus/index"
  get "privacy/index"
  get "loginhelp/index"
  get "executive_council/index"
  get "pla_presidents" => 'pla_presidents#index'
  get "history/index"
  get "commissions/index"
  get "cabinet/index"
  
  get "donate/index"
  get "membership/index"
  get "volunteer/index"
  get "photo/index"
  get "news" => "news#index"
  get "news/index" => 'news#index'
  get "news/show" => 'documents#show'
  get 'news/:id' => 'documents#show'

  get "platform/index"
  get "team/index"
  get "team/show"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  get 'aboutus' => 'aboutus#index'   
  get 'abcmember' => 'abcmember#index'
  get 'aboutdonations' => 'about_donations#index'
  get 'cabinet' => 'cabinet#index'
  get 'commissions' => 'commissions#index'
  get 'candidates' => 'candidates#index'
  get 'constitution' => 'constitution#index'
  get 'contact' => 'contact#index'
  get 'donate' => 'donate#index'
  get 'donationlimits' => 'donationlimits#index'
  get 'eligibility' => 'eligibility#index'
  get 'enewsletter' => 'enewsletter#subscribe'
  get 'executive_council' => 'executive_council#index'
  get 'getinvolved' => 'getinvolved#index'
  get 'history' => 'history#index'
  get 'home' => 'home#index'
  get 'leader' => 'leader#index'

  get 'logo' => 'logo#index'
  get 'membership' => 'membership#index'
  
  #get "mpps/index"
  get 'mpps' => 'mpps#index'
  get 'mpps/:id' => 'mpps#show'

  get 'ontarioliberalfund' => 'ontarioliberalfund#index'
  #get 'photo' => 'photo#index'

  get 'platform' => 'platform#index'
  get 'privacy' => 'privacy#index'
  get 'profile' => 'registrations#edit'   
  get 'redtrillium' => 'redtrillium#index'
  get 'register' => 'register#index'
  get 'taxablebenefits' => 'taxable_benefits#index'
  get 'team' => 'team#index'
  get 'team/:id' => 'team#show'
  get 'video' => 'video#index'
  get 'video/:id' => 'video#show'
  get 'volunteerextendedprofile' => 'volunteerextendedprofile#index'
  #get 'fbtest' => 'fbtest#index'
  #get 'fbtest/:id' => 'fbtest#show'



  
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

  devise_for :admins, controllers: { sessions: "admins/sessions" }

  namespace :admin do
    resources :documents do
      resources :attachments
    end
    resources :transactions
    get 'home' => 'home#home'
    get 'toolkit' => "documents#toolkit"
    get 'toolkit/:id' => "documents#toolkit_show"
    get 'transactions' => 'transactions#admin_index'
    get 'transaction_scopes/:id' => 'transactions#scopes'
    get 'petitions/:id' => 'petitions#index'
    get 'contact' => 'home#contact'
    get 'web' => 'home#web'
    get 'lit_samples' => 'home#lit_samples'
  end

  get '*a', :to => redirect('/404.html')
  #get '/', :to => redirect('home#index')

  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy]
    end
  end
end
