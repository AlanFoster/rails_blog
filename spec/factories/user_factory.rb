# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'alan'
    email 'alan@example.com'
    # password 'password'
    password_hash '$2a$10$MU.whOIgNMayu3siIWpQEeoPOfN95pbvCPW9l/ZvJrd96l2RsofBq'
    password_salt '$2a$10$MU.whOIgNMayu3siIWpQEe'
  end
end
