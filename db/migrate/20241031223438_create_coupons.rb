class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :title
      t.string :code
      t.boolean :redeemed, default: false
      t.float :discount_percentage

      t.timestamps
    end
  end
end
