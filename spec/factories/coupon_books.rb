FactoryBot.define do
  factory :coupon_book do
    title { Faker::TvShows::RickAndMorty.location }
    max_number_of_coupons {Faker::Number.number(digits: 3)}
    max_coupons_per_user {Faker::Number.number(digits: 2)}
  end
end
