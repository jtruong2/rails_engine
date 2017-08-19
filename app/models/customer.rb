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

  def self.customers_with_pending_invoices(id)
    joins(:invoices => [:merchant, :transactions]).where("merchant_id = ?", id).where(transactions: {result: 'failed'}).group("customers.id")

    #SELECT DISTINCT invoice_id FROM transactions WHERE result = 'success' AND invoice_id NOT IN ( SELECT invoice_id FROM transactions WHERE result != 'success');
  end
end
