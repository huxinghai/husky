# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_budget do
    project_id 1
    kind 1
    price 1.5
  end
end
