class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.find_by(safe_params)
  end

  def index
    render json: InvoiceItem.where(safe_params)
  end

  private

  def safe_params
    params.permit(:quantity, :unit_price, :created_at, :updated_at)
  end
end
