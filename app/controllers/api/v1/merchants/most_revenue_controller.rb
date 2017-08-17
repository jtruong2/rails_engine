class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: Merchant.top_merchants_by_revenue(safe_params)
  end

  private

  def safe_params
    params.permit(:quantity)
  end
end
