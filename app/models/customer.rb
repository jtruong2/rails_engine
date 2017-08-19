class Customer < ApplicationRecord
  has_many :invoices

  def self.return_associated_transactions(id)
    joins(:invoices => [:transactions])
    .where("customer.id = ?", id)
  end

  def self.favorite_merchant(id)
    joins(:invoices => [:merchant, :transactions])
    .where(transactions: {result: 'success'})
    .where("customers.id = ?", id)
    .group("merchant_id")
    .order("count_all DESC")
    .count
    .first
  end
end
