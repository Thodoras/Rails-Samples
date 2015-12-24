Rails.application.routes.draw do
  devise_for :admins
  resources :vessels, except: :show

  namespace :admin do
    resources :vessels
  end

  root to: 'vessels#index'
end
