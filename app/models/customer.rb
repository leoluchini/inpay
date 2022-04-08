# frozen_literal_string: true

class Customer < ApplicationRecord
  has_many :payments

  validates :fullname, presence: true
end
