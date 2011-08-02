Rails.application.routes.draw do
  # Add your extension routes here
  devise_scope :user  do
    get "/signup/seller" => "user_registrations#new", :as => :signup_seller, :defaults => { :user => {:role => "seller"} }
  end
end
