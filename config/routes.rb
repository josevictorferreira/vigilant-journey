# frozen_string_literal: true

Rails.application.routes.draw do
  resources :savings

  get '/savings/totals/month', to: 'savings#totals_month'
end
