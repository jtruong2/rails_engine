class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_all_by_unit_price(unit_price_params)
    unit_price_params["unit_price"] = (unit_price_params["unit_price"].to_f * 100).round
    where(unit_price_params)
  end

  def self.find_by_unit_price(unit_price_params)
    unit_price_params["unit_price"] = (unit_price_params["unit_price"].to_f * 100).round
    find_by(unit_price_params)
  end

  def self.top_items_based_on_revenue(limit = nil)
    joins(:invoice_items => [:invoice => [:transactions]])
    .merge(Transaction.successful_transactions)
    .group("items.id")
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(limit.values[0])
  end

  def self.most_sold_item(limit = nil)
    joins(:invoice_items => [:invoice => [:transactions]])
    .where(transactions: {result: 'success'})
    .group("items.id")
    .order("sum(quantity) DESC")
    .limit(limit.values[0])
  end
end
