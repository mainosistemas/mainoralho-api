FactoryBot.define do
  factory :project do
    sequence(:name) { |n|  "Projeto #{n+1}" }
  end
end