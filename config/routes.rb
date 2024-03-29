# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'devise/sessions',
                                    registrations: 'devise/registrations' }
  root 'posts#index'
  resources :posts, only: %i[create edit destroy new show update] do
    resources :comments, only: :create
    resources :likes, only: %i[create destroy]
  end
end
