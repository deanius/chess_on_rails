ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.

  # Default routes
  map.root :controller => "authentication", :conditions => {:canvas => false}

  map.auth       'authentication/:action',  :controller => 'authentication'
  map.login      'authentication/login',    :controller => 'authentication', :action => 'login'
  map.logout     'authentication/logout',   :controller => 'authentication', :action => 'logout'
  map.register   'authentication/register', :controller => 'authentication', :action => 'register'

  #allow moving from CURL - Although GET generally not acceptable, post won't work without the forgery protection
  map.create_move 'match/:match_id/moves/:notation', :controller => 'move', :action => 'create', :defaults => { :notation => nil }

  map.resources :match , :except => [:delete], :shallow => true, :collection => { :create => :post } do |match|
    # TODO match route for resign must be POST since destructive 
    match.resources :moves, :controller => :move, :only => [:create], :collection => { :create => :post }
    match.resource :chat #TODO limit chat routes to those needed, :only => [:create, :index, :chat]
  end

  #allow updating of gameplays via REST
  map.resources :gameplays, :only => [:show, :update]

  #sets controller courtesy of Sean
  map.resource :set, :member => {:change => :post}

  # Install the default routes as the lowest priority.
  map.connect ':controller/:id/:action'
  map.connect ':controller/:id/:action.:format'  
  
end
