# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    commentable_id 1
    commentable_type "MyString"
    user_id 1
    content "MyText"
    status false
    floor 1
    content_origin "MyText"
  end
end
