# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { '2.99' }
    iban { 'ES2114650100722030876293' }
    aasm_state { 'settled' }
    association :currency, factory: :currency
    association :customer, factory: :customer
  end
end
