FactoryBot.define do
  factory :user do
    username { "admin" }
    password_digest { "admin" }
  end
end
