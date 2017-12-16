FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    net_price { Faker::Number.decimal(2).to_f }
  end
end
