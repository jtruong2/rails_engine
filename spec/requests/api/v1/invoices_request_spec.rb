require 'rails_helper'
RSpec.describe "Invoices API" do
  it "sends a list of invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "can get one invoice by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    id = create(:invoice, merchant_id: merchant.id, customer_id: customer.id).id

    get "/api/v1/invoices/#{id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(id)
  end

  it "can find single invoice by status" do
    merchant = create(:merchant)
    customer = create(:customer)
    status = create(:invoice, merchant_id: merchant.id, customer_id: customer.id).status

    get "/api/v1/invoices/find?status=#{status}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["status"]).to eq(status)
  end

  it "can find single invoice by date" do
    merchant = create(:merchant)
    customer = create(:customer)
    example = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "March 17 2016")

    get "/api/v1/invoices/find?created_at=#{example.created_at}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(example.id)
  end

  it "can find all invoices by status" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant.id, customer_id: customer.id)
    invoice3 = create(:invoice, status: "failed", merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/find_all?status=#{invoice1.status}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "returns a random invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/random"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.class).to_not eq(Array)
  end

  it " returns a collection of associated transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns a collection of associated invoice items" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns a collection of associated items" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item1, item2, item3 = create_list(:item, 3, merchant_id: merchant.id)
    create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
    create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)
    create(:invoice_item, item_id: item3.id, invoice_id: invoice.id)


    get "/api/v1/invoices/#{invoice.id}/items"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns the associated customer" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(customer.id)
  end

  it "returns the associated merchant" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(merchant.id)
  end
end
