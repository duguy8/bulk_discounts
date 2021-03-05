FactoryBot.define do
  factory :discount do
    sequence(:name) { |n| "Sweet Discount#{n}" }
    quantity_threshold  { 10 }
    percentage_discount  { 20 }

    merchant
  end
end
