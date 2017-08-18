class Api::V1::RevenueController < ApplicationController
  def show
    
    render json: Merchant.merchant_total_revenue(params[:merchant_id])
  end

end
