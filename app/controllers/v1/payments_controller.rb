# frozen_string_literal: true

module V1
  class PaymentsController < ApplicationController
    def index
      @payments = PaymentsQueries.new(query_params).call
    end

    def create
      form = PaymentForm.new(payment_attributes: payment_params)
      return render json: { status: :created }, status: :created if form.save

      render json: { error: form.errors }, status: :unprocessable_entity
    end

    private

    def payment_params
      params.require(:payment)
            .permit(:customer_id, :currency_id, :amount, :iban)
    end

    def query_params
      params.permit(:customer_id, :currency_id, :aasm_state)
    end
  end
end
