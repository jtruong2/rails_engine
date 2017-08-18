class Api::V1::CustomerTransactionsController < ApplicationController
  def show
    render json: Transaction.customer_associated_transactions(params[:customer_id])
  end
end
