class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: Merchant.find_by(safe_params)
  end

  def index
    render json: Merchant.where(safe_params)
  end

  private

  def safe_params
    params.permit(:name, :created_at, :updated_at)
  end
end
