# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentForm do
  let(:customer) { create :customer }
  let(:currency) { create :currency }

  describe '#save' do
    subject { described_class.new(payment_attributes: attributes).save }

    context 'with invalid attributes' do
      let(:attributes) { {} }

      it 'do not creates a payment' do
        expect { subject }.to_not change { Payment.count }
      end
    end

    context 'with valid attributes' do
      let(:attributes) do
        { customer_id: customer.id, currency_id: currency.id, amount: 10, iban: 'ES123456' }
      end

      it 'creates a payment' do
        expect { subject }.to change { Payment.count }.by(1)
      end
    end
  end
end
