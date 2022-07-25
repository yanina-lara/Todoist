FactoryBot.define do
  factory :task do
    title { Faker::Team.name }
    description { Faker::Lorem.paragraph(2) }
    status { Faker::Number.between(from: 0, to: 1) }
    level{ Faker::Number.between(from: 1, to: 5) }
    deadline { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    association :user
  end
end
