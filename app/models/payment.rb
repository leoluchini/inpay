# frozen_literal_string: true

class Payment < ApplicationRecord
  include AASM

  belongs_to :customer
  belongs_to :currency

  validates :amount, numericality: { greater_than: 0 }
  validates :iban, presence: true

  aasm do
    state :processed, initial: true
    state :verified, :rejected, :settled, :archived

    event :verify do
      transitions from: :process, to: :verified
    end

    event :reject do
      transitions from: :process, to: :rejected
    end

    event :settle do
      transitions from: :verified, to: :settled
    end

    event :archive do
      transitions from: %i[processed rejected], to: :archived
    end
  end
end
