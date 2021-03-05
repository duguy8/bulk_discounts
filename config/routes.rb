Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #home
  root to: 'welcome#index'

  #admins
  resources :admin, only: [:index], controller: "admin/dashboard"

  namespace :admin do
    #admin/invoices
    resources :invoices, only: [:index, :show, :update]
    #admin/merchants
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
  end

  #merchants
  resources :merchants, only: [:show] do
    #merchants/dashboard
    resources :dashboard, only: [:index], controller: "merchants/dashboard"
    #merchants/discounts
    resources :discounts, only: [:index, :show, :new, :create, :destroy], controller: "merchants/discounts"
    #merchants/items
    resources :items, only: [:index, :show, :new, :create, :edit, :update], controller: "merchants/items"
    #merchants/invoices
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
  end

  #merchants/invoice_items
  resources :invoice_items, only: [:update], controller: "merchants/invoice_items"
end
