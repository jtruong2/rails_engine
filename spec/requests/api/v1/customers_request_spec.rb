require 'rails_helper'

describe 'Customers API' do
  xit "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  xit "can get one customer by it's id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  xit "can find a single object by name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    customer = JSON.parse(response.body)


    expect(response).to be_success
    expect(customer["first_name"]).to eq(first_name)
  end

  xit "can find a single object by date" do
    date = create(:customer).created_at

    get "/api/v1/customers/find?created_at=#{date}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["date"]).to eq(date)
  end

  xit "can find all objects by name" do
    person1, person2 = create_list(:customer, 2)

    get "/api/v1/customers/find_all?first_name=#{person1.first_name}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(2)
  end

  it "returns a random resource" do
    person1, person2, person3 = create_list(:customer, 3)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to_not eq(Array)
  end
end
