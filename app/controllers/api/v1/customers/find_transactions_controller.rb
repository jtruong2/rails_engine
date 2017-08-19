class Api::V1::Customers::FindTransactionsController < ApplicationController
  def show
    render json: Transaction.customer_associated_transactions(params[:customer_id])
  end
end
