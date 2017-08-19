class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    merchant = Customer.favorite_merchant(params[:customer_id])[0]
    render json: Merchant.find(merchant)
  end
end
