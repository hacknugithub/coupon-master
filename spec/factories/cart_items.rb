FactoryBot.define do
  factory :cart_item do
    quantity {Faker::Number.between(from: 1, to: 10)}
  end
end
