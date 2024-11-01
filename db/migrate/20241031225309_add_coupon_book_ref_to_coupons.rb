class AddCouponBookRefToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_reference :coupons, :coupon_book, null: false, foreign_key: true
  end
end
