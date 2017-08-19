require 'rails_helper'
RSpec.describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "finds a single item by id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it "finds a single item by name" do
    merchant = create(:merchant)
    name = create(:item, merchant_id: merchant.id).name

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(name)
  end

  it "finds a single item by description" do
    merchant = create(:merchant)
    description = create(:item, merchant_id: merchant.id).description

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["description"]).to eq(description)
  end

  it "finds all items by name" do
    merchant = create(:merchant)
    item1, item2 = create_list(:item, 2, merchant_id: merchant.id)
    item3 = create(:item, name: "big toy", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=#{item1.name}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it "finds all items by unit_price" do
    merchant = create(:merchant)
    item1, item2 = create_list(:item, 2, merchant_id: merchant.id, unit_price: 12345)
    item3 = create(:item, unit_price: 10000, merchant_id: merchant.id)
    price = (item1.unit_price / 100)
    get "/api/v1/items/find_all?unit_price=#{price}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it "returns a random item" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item.class).to_not eq(Array)
  end

  it "returns a collection of associated invoice items" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    merchant_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_item['id']).to eq(merchant.id)
  end
end
