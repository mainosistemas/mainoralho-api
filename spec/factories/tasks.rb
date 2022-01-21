FactoryBot.define do
  factory :task do
    name { Faker::Space.planet }
    description { "Task test" }
    sprint
    owner { create(:user) }
  end
end