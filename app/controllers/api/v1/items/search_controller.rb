class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(safe_params)
  end

  def index
    render json: Item.where(safe_params)
  end
  
  private

  def safe_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
