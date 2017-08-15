class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: Transaction.find_by(safe_params)
  end

  def index
    render json: Transaction.where(safe_params)
  end

  private

  def safe_params
    params.permit(:credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
