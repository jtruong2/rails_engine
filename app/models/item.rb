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
end
