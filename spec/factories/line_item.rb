FactoryBot.define do
  factory :line_item do
    quantity { Faker::Number.between(1, 100) }
    product
    order
  end
end
