class Api::V1::Items::SearchController < ApplicationController
  def show
    if safe_params["unit_price"]
      render json: Item.find_by_unit_price(safe_params)
    else
      render json: Item.find_by(safe_params)
    end
  end

  def index
    if safe_params["unit_price"]
      render json: Item.find_all_by_unit_price(safe_params)
    else
      render json: Item.where(safe_params)
    end
  end

  private

  def safe_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :id)
  end
end
