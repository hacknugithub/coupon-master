class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_create -> { self.cart.update_total }
end
