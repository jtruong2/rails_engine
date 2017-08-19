class Api::V1::Merchants::SingleMerchantRevenueController < ApplicationController
  def show
    if safe_params[:date]
      render json: Merchant.total_revenue_for_merchant_for_specific_invoice_date(safe_params, params[:merchant_id]), serializer: SingleMerchantSerializer
    else
      render json: Merchant.total_revenue_for_single_merchant(params[:merchant_id]), serializer: SingleMerchantSerializer
    end
  end

  private

  def safe_params
    params.permit(:date)
  end
end
