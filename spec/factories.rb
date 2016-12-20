FactoryGirl.define do
  factory :user do
    username 'test'
    email 'test@test.test'
    password 'test'
  end

  factory :salary do
    user
  end
end