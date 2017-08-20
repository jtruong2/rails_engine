class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.top_merchants_by_revenue(limit = nil)
    limit = limit.values[0].to_i
    joins(:invoices => [:transactions, :invoice_items])
    .merge(Transaction.successful_transactions)
    .group(:id)
    .order("sum(quantity * unit_price) DESC")
    .limit(limit)
  end

  def self.top_merchants_by_total_number_of_items_sold(limit = nil)
    if limit != nil
      limit = limit.values[0].to_i
    end
    joins(:invoices => [:transactions, :invoice_items])
    .merge(Transaction.successful_transactions)
    .group(:id)
    .order("sum(quantity) DESC")
    .limit(limit)
  end

  def self.total_revenue_by_date_across_all_merchants(date)
    date = date.values[0]
    joins(:invoices => [:transactions, :invoice_items])
    .merge(Transaction.successful_transactions)
    .group("invoices.created_at")
    .where("invoices.created_at = ?", date)
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.total_revenue_for_single_merchant(id)
    joins(:invoices => [:transactions, :invoice_items])
    .merge(Transaction.successful_transactions)
    .where("merchants.id = ?", id)
    .where(transactions: {result: 'success'})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.total_revenue_for_merchant_for_specific_invoice_date(date, id)
    date = date.values[0][0..18]
    joins(:invoices => [:transactions, :invoice_items])
    .merge(Transaction.successful_transactions)
    .where("merchants.id = ?", id)
    .where("invoices.created_at = ?", date)
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.favorite_customer(id)
    joins(:invoices => [:customer, :transactions])
    .merge(Transaction.successful_transactions)
    .where("merchant_id = ?", id)
    .group("customer_id")
    .order("count_all DESC")
    .count
    .first
  end
end
