class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.total_revenue_by_date_across_all_merchants(safe_params), serializer: TotalRevenueSerializer
  end

  private

  def safe_params
    params.permit(:date)
  end
end
