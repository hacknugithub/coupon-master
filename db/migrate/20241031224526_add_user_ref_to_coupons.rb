class AddUserRefToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_reference :coupons, :user, null: true, foreign_key: true
  end
end
