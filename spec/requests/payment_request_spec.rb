# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payment', type: :request do
  let(:customer) { create(:customer) }
  let(:currency) { create(:currency) }

  describe 'index' do
    subject do
      get v1_payments_path, params: params
    end

    before do
      create_list(:payment, 5)
      create_list(:payment, 5, customer: customer)
    end

    context 'without query params' do
      let(:params) {}

      it 'returns data' do
        subject
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(10)
      end
    end

    context 'with query params' do
      context 'filter by customer_id' do
        let(:params) { {customer_id: customer.id} }

        it 'returns all payments for the customer' do
          subject
          expect(response).to be_successful
          expect(JSON.parse(response.body)['data'].size).to eq(5)
        end
      end

      context 'filter by status' do
        let(:params) { {aasm_state: 'rejected'} }
        let!(:payment) { create(:payment, aasm_state: 'rejected') }

        it 'returns all payments for the customer' do
          subject
          expect(response).to be_successful
          expect(JSON.parse(response.body)['data'].size).to eq(1)
        end
      end
    end
  end

  describe 'create' do
    subject do
      post v1_payments_path, params: params
    end

    context 'with valid attributes' do
      let(:params) do
        {
          payment:
          { customer_id: customer.id,
            currency_id: currency.id,
            amount: 10,
            iban: 'ES12345678' }
        }
      end

      it do
        expect { subject }.to change { Payment.count }.by(1)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        { payment: { customer_id: customer.id, currency_id: currency.id, amount: 10 } }
      end

      it 'got an error' do
        subject
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error: { iban: ["can't be blank"] } }.to_json)
      end
    end
  end
end
