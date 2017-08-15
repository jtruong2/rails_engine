class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: Invoice.find_by(safe_params)
  end

  def index
    render json: Invoice.where(safe_params)
  end

  private

  def safe_params
    params.permit(:status, :created_at, :updated_at)
  end
end
