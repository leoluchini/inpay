# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    fullname { Faker::Name.name }
  end
end
