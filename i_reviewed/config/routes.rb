Rails.application.routes.draw do
  
  resources(:sessions, only: [:new, :create, :destroy])
  get("/login" => "sessions#new", as: "login")
  delete("/logout" => "sessions#destroy", as: "logout")

  resources(:books) do
    resources(:notes, only: [:create, :destroy])
  end
  root("books#index")
end
