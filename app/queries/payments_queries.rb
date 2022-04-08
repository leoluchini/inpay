# frozen_string_literal: true

class PaymentsQueries
  attr_reader :query

  def initialize(query = {})
    @query = query
  end

  def call
    relation.where(query)
  end

  private

  def relation
    Payment.includes(:customer)
  end
end
