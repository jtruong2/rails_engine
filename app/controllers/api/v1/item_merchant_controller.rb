class Api::V1::ItemMerchantController < ApplicationController
  def show
    render json: Item.find(params[:item_id]).merchant
  end
end
