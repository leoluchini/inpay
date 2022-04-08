# frozen_string_literal: true

class PaymentForm < BaseForm
  def initialize(payment_attributes:)
    super(payment_attributes)
    @content = payment
  end

  private

  def payment
    Payment.new(attributes)
  end
end
