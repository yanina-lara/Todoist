FactoryBot.define do
  factory :tag do
    name { Faker::Team.name }
    association :user
  end
end
