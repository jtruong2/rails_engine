class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: Customer.find_by(safe_params)
  end

  def index
    render json: Customer.where(safe_params)
  end

  private

  def safe_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
