# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { 'qwerty' }
    username { Faker::Internet.username }
    full_name { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
  end
end
