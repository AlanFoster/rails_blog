FactoryGirl.define do
  factory :post do
    title "Blog Title"
    content "Blog Content"
    created_at { Time.now }
  end
end
