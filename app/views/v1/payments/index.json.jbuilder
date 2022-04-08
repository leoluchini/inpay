# frozen_string_literal: true

json.data do
  json.array! @payments do |payment|
    json.id payment.id
    json.fullname payment.customer.fullname
    json.amount payment.amount
    json.currency payment.currency.name
    json.status payment.aasm_state
  end
end
