FactoryBot.define do
  factory :sprint do
    name { Faker::Space.planet }
    project
    owner { create(:user) }
  end
end
