class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.float :total
      t.float :discount_total
      t.boolean :purchased, default: false

      t.timestamps
    end
  end
end
