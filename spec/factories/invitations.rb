# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    from_user_id 1
    description "MyText"
    to_user_id 1
    email "MyString"
    team_id 1
  end
end
