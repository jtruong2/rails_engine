class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful_transactions, -> {where(result: 'success')}

  def self.customer_associated_transactions(customer)
    joins(:invoice => [:customer])
    .where("customer_id = ?", customer)
  end
end
