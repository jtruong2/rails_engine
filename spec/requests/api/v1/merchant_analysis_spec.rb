require 'rails_helper'
RSpec.describe "Merchant Analysis" do
  it "returns the top x merchants ranked by total revenue" do
    top = 2
    merchants = create_list(:merchant, 5)
    items = create_list(:item, 30, merchant_id:)
    invoice_item1 = create_list(:invoice_items, unit_price: 30.0, quantity: 5)

  end
end
