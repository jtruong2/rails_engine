class Api::V1::MerchantItemsController < ApplicationController
  def show
    render json: Merchant.find(params[:merchant_id]).items
  end
end
