FactoryBot.define do
  factory :project do
    sequence(:name) { |n|  "Projeto #{n+1}" }
    owner { create(user) }
  end
end