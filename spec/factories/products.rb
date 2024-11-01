FactoryBot.define do
  factory :product do
    title { Faker::TvShows::RickAndMorty.character }
    description {Faker::TvShows::RickAndMorty.quote }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
