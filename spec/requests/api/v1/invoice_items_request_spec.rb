require 'rails_helper'
RSpec.describe "Invoice items API" do
  it "sends a list of invoice items" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it "finds a single invoice item by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = create(:invoice_item, item_id: item.id, invoice_id: invoice.id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(id)
  end

  it "finds a single invoice item by unit price" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    price = create(:invoice_item, item_id: item.id, invoice_id: invoice.id).unit_price

    get "/api/v1/invoice_items/find?unit_price=#{price}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq(price)
  end

  it "finds all invoice items by quantity" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, quantity: 3, item_id: item.id, invoice_id: invoice.id)
    inv_item3 = create(:invoice_item, quantity: 30, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?quantity=#{inv_item1.quantity}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
  end

  it "finds all instances of invoice items by invoice_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
  end

  it "finds all instances by item id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
  end

  it "returns a random invoice item" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to_not eq(Array)
  end

  it "returns the associated invoice" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    inv = JSON.parse(response.body)

    expect(response).to be_success
    expect(inv["id"]).to eq(invoice.id)
  end

  it "returns the associated item" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    inv_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(inv_item["id"]).to eq(item.id)
  end
end
