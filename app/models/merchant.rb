class Merchant < ApplicationRecord
  has_many :invoices

  def self.top_merchants_by_revenue(limit)
    limit = limit.values[0].to_i
    joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(quantity * unit_price) DESC")
    .limit(limit)
  end

  def self.top_merchants_by_total_number_of_items_sold(limit)
    limit = limit.values[0].to_i
    joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("sum(quantity) DESC")
    .limit(limit)
  end

  def self.total_revenue_by_date_across_all_merchants(date)
    date = date.values[0]
    joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .where(invoice_items: {created_at: (date + " 00:00:00"...date + " 23:59:59")})
    .group(:id)
  end
end
