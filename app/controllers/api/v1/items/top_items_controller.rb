class Api::V1::Items::TopItemsController < ApplicationController
  def index
    render json: Item.top_items_based_on_revenue(safe_params)
  end

  private

  def safe_params
    params.permit(:quantity)
  end
end
