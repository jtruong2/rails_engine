class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: Merchant.top_merchants_by_total_number_of_items_sold(safe_params)
  end

  private

  def safe_params
    params.permit(:quantity)
  end
end
