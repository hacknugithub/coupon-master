class Coupon < ApplicationRecord
  belongs_to :coupon_book
  belongs_to :user, optional: true
  belongs_to :cart, optional: true

  DISCOUNT_BY_PURCHASE_AMOUNT = -> (amount) {
    case amount
    when 0..50
      0.05
    when 50..100
      0.10
    when 100..200
      0.15
    when 200..500
      0.20
    when 500..1000
      0.30
    when 1000..Float::INFINITY
      0.35
    else
      0
    end
  }

  def self.create_coupon(user_id, coupon_book, total)
      discount_percentage = DISCOUNT_BY_PURCHASE_AMOUNT.call(total)
      self.create({
        title: "#{coupon_book.title} #{(discount_percentage * 100).to_i} OFF", 
        code: CodeGenerator::Generator.generate(length: 12), 
        redeemed: false, 
        discount_percentage: discount_percentage, 
        coupon_book_id: coupon_book.id, 
        user_id: user_id,
      })
  end
end
