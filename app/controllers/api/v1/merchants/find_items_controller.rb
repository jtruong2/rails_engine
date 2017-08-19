class Api::V1::Merchants::FindItemsController < ApplicationController
  def show
    render json: Merchant.find(params[:merchant_id]).items
  end
end
