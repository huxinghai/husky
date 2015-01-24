# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_attachment do
    project_id 1
    attachment_id "MyString"
  end
end
