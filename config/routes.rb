Rails.application.routes.draw do

  root to: 'application#index'
  get ':word' => 'application#post'
  get 'topic/:id' => 'application#topic'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
