# frozen_string_literal: true

Rails.application.routes.draw do
  resources :savings

  get '/savings/current_month', to: 'savings#current_month'
end
