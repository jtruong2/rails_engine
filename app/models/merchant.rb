class Merchant < ApplicationRecord
  has_many :invoices

  def self.top_merchants_by_revenue(variable_number)
    
  end
end
