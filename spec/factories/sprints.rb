FactoryBot.define do
  factory :sprint do
    name { Faker::Space.planet }
    project
  end
end
