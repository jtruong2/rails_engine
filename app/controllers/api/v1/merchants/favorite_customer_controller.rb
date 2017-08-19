class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    customer = Merchant.favorite_customer(params[:merchant_id])[0]
    render json: Customer.find(customer)
  end
end
