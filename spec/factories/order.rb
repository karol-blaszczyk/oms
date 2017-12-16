FactoryBot.define do
  factory :order do
    order_date { Faker::Date.forward(Faker::Number.between(1,10)) }
    vat { Faker::Number.between(0.01, 1.0).round(2) }
  end
end
