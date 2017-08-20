require 'rails_helper'
RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "can get one merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(id)
  end

  it "can find single merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["name"]).to eq(name)
  end

  it "can find single merchant by date" do
    example = create(:merchant, created_at: "May 13 2004")

    get "/api/v1/merchants/find?created_at=#{example.created_at}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(example.id)
  end

  it "can find all merchants by name" do
    company1, company2 = create_list(:merchant, 2)
    company3 = create(:merchant, name: "Sams Club")

    get "/api/v1/merchants/find_all?name=#{company1.name}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "can return a random merchant" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.class).to_not be(Array)
  end

  it "returns a collection of items associated with that merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "returns a collection of invoices associated with that merchant from their known orders" do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "total revenue for merchant for specific invoice date" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
    transaction = create(:transaction, invoice_id: invoice.id, result: "success")
    create(:invoice_item, invoice_id: invoice.id, unit_price: 1000, quantity: 2, item_id: item.id)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoice.created_at}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["revenue"]).to eq("20.0")
  end

  it "returns total revenue for a single merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)
    item = create(:item, merchant_id: merchant.id)
    create_list(:invoice_item, 3, unit_price: 1000, quantity: 2, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["revenue"]).to eq("60.0")
  end

  it "returns customers with pending invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id, result: 'failed')
    item = create(:item, merchant_id: merchant.id)
    create_list(:invoice_item, 3, unit_price: 1000, quantity: 2, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.first["id"]).to eq(customer.id)
  end

  it "returns favorite customer" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
    invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(customer_2.id)
  end

  it "returns top merchants by total number of items sold" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 10, item_id: item_1.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 5, item_id: item_2.id)

    get "/api/v1/merchants/most_items?quantity=1"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.first["id"]).to eq(merchant_1.id)
  end

  it "returns top merchants by revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 10, unit_price: 10, item_id: item_1.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 5, unit_price: 5, item_id: item_2.id)

    get '/api/v1/merchants/most_revenue?quantity=1'

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.first["id"]).to eq(merchant_1.id)
  end

  it "returns total revenue by date across all merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, created_at: "2011-08-08")
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, created_at: "2011-08-08")
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 2, unit_price: 1000, item_id: item_1.id)
    create(:invoice_item, invoice_id: invoice_1.id, quantity: 1, unit_price: 2000, item_id: item_2.id)

    get "/api/v1/merchants/revenue?date=2011-08-08"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["total_revenue"]).to eq("40.0")
  end
end
