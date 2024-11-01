class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user
  belongs_to :coupon, optional: true

  def apply_discount(coupon)
    self.update!({
      coupon_id: coupon.id,
      total: total,
      discount_total: calculate_total_with_coupon_discount(total, coupon.discount_percentage)
    })
    coupon.update!(redeemed: true)
  end

  def total
    total ||= self.cart_items ? self.cart_items.reduce(0){|sum, it| sum += (it.quantity * it.product.price) } : 0
    total
  end

  def update_total
    self.update!(total: total)
  end

  def calculate_total_with_coupon_discount(total, coupon_percentage_discount)
    total -= total * coupon_percentage_discount
  end
end
