class User < ApplicationRecord
  has_many :coupons
  has_many :carts
end
