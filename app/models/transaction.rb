class Transaction < ApplicationRecord
  belongs_to :invoice

  # def self.customer_transactions(customer)
  #
  #   invoice.where(customer_id: customer)
  # end
end
