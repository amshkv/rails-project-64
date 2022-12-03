# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'devise/sessions',
                                    registrations: 'devise/registrations' }
  root 'posts#index'
  resources :posts
end
