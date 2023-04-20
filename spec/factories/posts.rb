# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user_id { 1 }
    title { 'MyString' }
    body { 'MyString' }
  end
end
