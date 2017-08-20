class Customer < ApplicationRecord
  has_many :invoices

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
    find_by_sql ["SELECT * FROM customers JOIN
      (SELECT i.customer_id FROM invoices i
      JOIN transactions t ON i.id = t.invoice_id
      WHERE t.result = 'failed' AND i.merchant_id = ?
      EXCEPT SELECT i.customer_id FROM invoices i
      JOIN transactions t ON i.id = t.invoice_id
      WHERE t.result = 'success' AND i.merchant_id = ? )
      only_failed ON only_failed.customer_id = customers.id", id, id]
  end
end
