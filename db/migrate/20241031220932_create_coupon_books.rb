class CreateCouponBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_books do |t|
      t.string :title
      t.integer :max_number_of_coupons
      t.integer :max_coupons_per_user

      t.timestamps
    end
  end
end
