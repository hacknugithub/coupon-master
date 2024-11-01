class AddCouponRefToCarts < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :coupon, null: true, foreign_key: true
  end
end
