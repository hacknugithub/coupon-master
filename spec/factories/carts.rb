FactoryBot.define do
  factory :cart do
    total { Faker::Number.decimal(l_digits: 2) }
    discount_total { 0}
    purchased { false }
  end
end
