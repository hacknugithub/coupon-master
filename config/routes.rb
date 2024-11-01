Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  get 'purchase', to: 'carts#purchase'
  resources :coupons
  get 'validate_coupon', to: 'coupons#validate_coupon'
  resources :coupon_books
  resources :products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
