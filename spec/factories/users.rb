# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password' }
    username { 'test' }
    full_name { 'hoge' }
    body { 'MyString' }
    slug { 'foo' }
  end
end
