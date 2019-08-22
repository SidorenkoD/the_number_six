Rails.application.routes.draw do
  resources :issues
  post :foo, to: 'issues#foo'
end
