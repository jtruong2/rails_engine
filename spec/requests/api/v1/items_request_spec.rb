require 'rails_helper'
RSpec.describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "finds a single item by id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["id"]).to eq(id)
  end

  it "finds a single item by name" do
    merchant = create(:merchant)
    name = create(:item, merchant_id: merchant.id).name

    get "/api/v1/items/find?name=#{name}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["name"]).to eq(name)
  end

  it "finds a single item by description" do
    merchant = create(:merchant)
    description = create(:item, merchant_id: merchant.id).description

    get "/api/v1/items/find?description=#{description}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["description"]).to eq(description)
  end

  it "finds all items by name" do
    merchant = create(:merchant)
    item1, item2 = create_list(:item, 2, merchant_id: merchant.id)
    item3 = create(:item, name: "big toy", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=#{item1.name}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "find single item by unit price" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, unit_price: 12345)
    price = (item.unit_price / 100).to_s
    get "/api/v1/items/find?unit_price=#{price}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output["unit_price"]).to eq(price)
  end

  it "finds all items by unit_price" do
    merchant = create(:merchant)
    item1, item2 = create_list(:item, 2, merchant_id: merchant.id, unit_price: 12345)
    item3 = create(:item, unit_price: 10000, merchant_id: merchant.id)
    price = (item1.unit_price / 100)
    get "/api/v1/items/find_all?unit_price=#{price}"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(2)
  end

  it "returns a random item" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/random"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.class).to_not eq(Array)
  end

  it "returns a collection of associated invoice items" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output.count).to eq(3)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output['id']).to eq(merchant.id)
  end

  it "returns most sold item" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    create_list(:invoice_item, 2, invoice_id: invoice_2.id, item_id: item_2.id)

    get "/api/v1/items/most_items?quantity=1"

    output = JSON.parse(response.body)

    expect(response).to be_success
    expect(output).to eq(item_2.id)
  end

  # it "returns best day associated with one item" do
  #   merchant = create(:merchant)
  #   customer = create(:customer)
  #   item = create(:item, merchant_id: merchant.id)
  #   invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
  #   invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
  #   create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id, unit_price: 3000, quantity: 10)
  #   create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id, unit_price: 3000, quantity: 2)
  #
  #   get "/api/v1/items/#{item.id}/best_day"
  #
  #   output = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(output["best_day"]).to eq(invoice_1.created_at)
  # end
end
