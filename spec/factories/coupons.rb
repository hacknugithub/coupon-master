FactoryBot.define do
  factory :coupon do
    title {Faker::TvShows::RickAndMorty.location}
    code {Faker::Alphanumeric.alpha(number: 10)}
    redeemed {false}
    discount_percentage {Faker::Number.between(from: 1, to: 100) / 100.0}
  end
end
