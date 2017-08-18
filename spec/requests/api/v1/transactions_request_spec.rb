require 'rails_helper'
RSpec.describe "Transactions API" do
  it "sends a list on Transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
  end

  it "can find transaction by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    id = create(:transaction, invoice_id: invoice.id).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "can find a single transaction by result" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    result = create(:transaction, invoice_id: invoice.id).result

    get "/api/v1/transactions/find?result=#{result}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["result"]).to eq(result)
  end

  it "can find a single transaction by credit_card_number" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    cc_num = create(:transaction, invoice_id: invoice.id).credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{cc_num}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["credit_card_number"]).to eq(cc_num)
  end

  it "can find all transactions by result" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    tr1, tr2 = create_list(:transaction, 2, invoice_id: invoice.id)
    tr3 = create(:transaction, result: "failed", invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?result=#{tr1.result}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(2)
  end

  it "returns a random transaction" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    tr1, tr2 = create_list(:transaction, 2, invoice_id: invoice.id)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction.class).to_not eq(Array)
  end

  it "returns the associated invoice" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    transaction_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_invoice["id"]).to eq(invoice.id)
  end
end
