class Api::V1::Merchants::CustomerPendingInvoicesController < ApplicationController
  def show
    render json: Customer.customers_with_pending_invoices(params[:merchant_id])
  end

  private

  def safe_params
    params.permit(:merchant_id)
  end
end
