class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    if safe_params[:unit_price]
      render json: InvoiceItem.find_by_unit_price(safe_params)
    else
      render json: InvoiceItem.find_by(safe_params)
    end
  end

  def index
    if safe_params[:unit_price]
      render json: InvoiceItem.find_all_by_unit_price(safe_params)
    else
      render json: InvoiceItem.where(safe_params)
    end
  end

  private

  def safe_params
    params.permit(:quantity, :unit_price, :created_at, :updated_at, :item_id, :id, :invoice_id)
  end
end
