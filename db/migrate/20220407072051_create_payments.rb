# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :iban, null: false
      t.float :amount, null: false
      t.string :aasm_state, null: false
      t.belongs_to :currency, index: true
      t.belongs_to :customer, index: true
      t.timestamps
    end
  end
end
