class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.best_day(id)
    joins(:transactions, :invoice_items => [:item])
    .merge(Transaction.successful_transactions)
    .where("items.id = ?", id)
    .group("invoices.id")
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(1)
  end
end
