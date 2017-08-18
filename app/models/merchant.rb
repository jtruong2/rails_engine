class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

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
    .where(invoices: {created_at: date})
    .sum("invoice_items.quantity * invoice_items.unit_price")

    # SELECT sum(invoice_items.quantity * invoice_items.unit_price)
    # AS revenue, invoices.created_at FROM "merchants"
    # INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id"
    # INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id"
    # INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id"
    # WHERE invoices.created_at = '2012-03-16 11:55:05' GROUP BY invoices.created_at
  end

  def self.total_revenue(id)
    revenue = Merchant.joins(:invoices => [:transactions, :invoice_items])
    .where("merchants.id = ?", id.to_i)
    .where(transactions: {result: 'success'})
    .sum("invoice_items.quantity * invoice_items.unit_price")
    {:total_revenue => revenue}
  end

  # def self.all_items_for_merchant(id)
  #
  # end
end
