require 'rails_helper'
RSpec.describe "Invoice items API" do
  it "sends a list of invoice items" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "finds a single invoice item by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = create(:invoice_item, item_id: item.id, invoice_id: invoice.id).id

    get "/api/v1/invoice_items/#{id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(id)
  end

  it "finds a single invoice item by unit price" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, unit_price: 12345)
    price = (invoice_item.unit_price / 100).to_s

    get "/api/v1/invoice_items/find?unit_price=#{price}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["unit_price"]).to eq(price)
  end

  it "finds single invoice item by invoice_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice.id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["invoice_id"]).to eq(invoice.id)
  end

  it "finds all by unit price" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, unit_price: 12345, item_id: item.id, invoice_id: invoice.id)
    price = (inv_item1["unit_price"] / 100).to_s

    get "/api/v1/invoice_items/find_all?unit_price=#{price}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "finds all invoice items by quantity" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, quantity: 3, item_id: item.id, invoice_id: invoice.id)
    inv_item3 = create(:invoice_item, quantity: 30, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?quantity=#{inv_item1.quantity}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "finds all instances of invoice items by invoice_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "finds all instances by item id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    inv_item1, inv_item2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "returns a random invoice item" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/random"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.class).to_not eq(Array)
  end

  it "returns the associated invoice" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(invoice.id)
  end

  it "returns the associated item" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(item.id)
  end
end
