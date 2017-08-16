class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.customer_transactions
    
  end
end
