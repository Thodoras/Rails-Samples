Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :movies do
  	member do
  	  put("like", to: "movies#upvote")
  	  put("dislike", to: "movies#downvote")
  	  put("unvote", to: "movies#unvote")
  	end
  end
  root('movies#index')
  get "/submits" => "movies#submits"
end
