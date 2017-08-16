class Api::V1::TransactionsController < ApplicationController
  def index
    if params
      
    render json: Transaction.all
  end

  def show
    render json: Transaction.find(params[:id])
  end
end
