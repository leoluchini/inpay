# frozen_literal_string: true

class Currency < ApplicationRecord
  has_many :payments

  validates :code, presence: true
  validates :name, presence: true
  validates :symbol, presence: true
end
