class Api::V1::MerchantInvoicesController < ApplicationController
  def show
    render json: Merchant.find(params[:merchant_id]).invoices
  end
end
