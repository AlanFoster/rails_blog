FactoryGirl.define do
  factory :post do
    title Faker::Lorem.word
    content Faker::Lorem.paragraph
    created_at { Time.now }
  end
end
