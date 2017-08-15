require 'rails_helper'
RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can find single merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end

  it "can find single merchant by date" do
    example = create(:merchant, created_at: "May 13 2004")

    get "/api/v1/merchants/find?created_at=#{example.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(example.id)
  end

  it "can find all merchants by name" do
    company1, company2 = create_list(:merchant, 2)
    company3 = create(:merchant, name: "Sams Club")

    get "/api/v1/merchants/find_all?name=#{company1.name}"

    companies = JSON.parse(response.body)

    expect(response).to be_success
    expect(companies.count).to eq(2)
  end

  it "can return a random merchant" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.class).to_not be(Array)
  end
end
