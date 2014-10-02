FactoryGirl.define do
  factory :post do
    title Faker::Lorem.words(3).join(' ')
    content Faker::Lorem.paragraph
    created_at { Time.now }
  end
end
