FactoryBot.define do
  factory :appointment do
    start_at { "2020-12-12 19:55:50" }
    user_id { 1 }
  end
end
