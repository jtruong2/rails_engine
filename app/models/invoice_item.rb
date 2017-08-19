class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.find_by_unit_price(unit_price_params)
    unit_price_params["unit_price"] = unit_price_params["unit_price"].to_f * 100
    find_by(unit_price_params)
  end

  def self.find_all_by_unit_price(unit_price_params)
    unit_price_params["unit_price"] = unit_price_params["unit_price"].to_f * 100
    where(unit_price_params)
  end
end
