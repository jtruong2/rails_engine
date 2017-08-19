class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.most_sold_item(safe_params)
  end

  private

  def safe_params
    params.permit(:quantity)
  end
end
