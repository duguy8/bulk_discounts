FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "#{Faker::JapaneseMedia::Naruto.character} #{n}" }
    sequence(:last_name) { |n| "#{Faker::JapaneseMedia::DragonBall.race} #{n}" }
  end
end
