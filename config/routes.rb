V44::Application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    invitations: 'invitations',
    sessions: 'users/sessions'
  }

  get 'party_history/index'

  resources :lawnsign_requests
  resources :volunteers
  resources :photos
  resources :videos
  resources :enewsletters
  resources :tasks
  resources :events

  get 'validate_user' => 'users#validate'

  get 'create_account' => 'users#edit'

  get 'find_riding' => 'riding_addresses#index'


  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'home#index'
  end


  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'
  
  get 'partyhistory' => 'party_history#index'
  get 'constitution/index' => 'constitution#index'
  get 'constitution/show' => 'constitution#show'
  get 'constitution/:id' => 'constitution#show'
  get 'my_liberal/index'
  #get 'profile/index'
  #get 'register/index'
  #get 'login/index'
  get 'volunteer_extended_profile/index'
  get 'volunteer_extended_profile/show'
  get 'donation_limits/index'
  get 'logo/index'
  get 'abc_member/index'
  #get 'contact/index'
  get 'candidates/index'
  #get 'fb_test/index'
  #get 'fb_test/show'
  get 'redtrillium/index'
  get 'ontarioliberalfund/index'
  get 'eligibility/index'
  get 'getinvolved/index'
  get 'aboutus/index'
  get 'privacy/index'
  get 'loginhelp/index'
  get 'executive_council/index'
  get 'pla_presidents' => 'pla_presidents#index'
  get 'history/index'
  get 'commissions/index'
  get 'cabinet/index'
  
  get 'donate/index'
  get 'membership/index'
  get 'volunteer/index'
  get 'photo/index'
  get 'news' => 'news#index'
  get 'news/index' => 'news#index'
  get 'news/show' => 'news#show'
  get 'news/:id' => 'news#show'

  get 'platform/index'
  get 'team/index'
  get 'team/show'

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
  
  #get 'mpps/index'
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

  get 'toolkit' => 'toolkit#index'
  get 'toolkit/:id' => 'toolkit#show'


  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  namespace :admin do

    get '/' => 'home#home'
    resources :documents do
      resources :attachments
    end
    resources :transactions do

    end
    resources :events
    resources :users do
    end

    get 'transactions' => 'transactions#admin_index'
    get 'transaction_scopes/:id' => 'transactions#scopes'
    get 'transaction_user/:id', to: 'transactions#find_user'

    get 'search/users' => 'users#search'
    get 'search/transactions' => 'transactions#search'
    get 'search/events' => 'events#search'
    get 'rapportive' => 'users#rapportive'
    get 'home' => 'home#home'
    get 'petitions/:id' => 'petitions#index'
    get 'contact' => 'home#contact'
    get 'web' => 'home#web'
    get 'lit_samples' => 'home#lit_samples'
  end

  get 'friends' => 'users#friends'

  #get '*a', :to => redirect('/404.html')
  get '/*.aspx' => redirect('users/registrations#new')

  namespace :api do
    namespace :olp  do
      resources :tokens,:only => [:create, :destroy]
    end
  end

  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
