require 'rails_helper'

describe 'Customers API' do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_success

    output = JSON.parse(response.body)

    expect(output.count).to eq(3)
  end

  it "can get one customer by it's id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(id)
  end

  it "can find a single object by name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    output = JSON.parse(response.body)


    expect(response).to be_success
    expect(output["first_name"]).to eq(first_name)
  end

  it "can find a single object by date" do
    example = create(:customer, created_at: "May 13 2003")

    get "/api/v1/customers/find?created_at=#{example.created_at}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(example.id)
  end

  it "can find all objects by name" do
    person1, person2 = create_list(:customer, 2)

    get "/api/v1/customers/find_all?first_name=#{person1.first_name}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "returns a random resource" do
    person1, person2, person3 = create_list(:customer, 3)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.class).to_not eq(Array)
  end

  it "returns a collection of associated invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/customers/#{customer.id}/invoices"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns a collection of associated transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns favorite merchant" do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice_1, invoice_2 = create_list(:invoice, 2, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    output = JSON.parse(response.body)
    expect(response).to be_success
    expect(output["id"]).to eq(merchant_1.id)
  end
end
