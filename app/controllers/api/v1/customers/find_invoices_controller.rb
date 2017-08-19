class Api::V1::Customers::FindInvoicesController < ApplicationController
  def show
    render json: Customer.find(params[:customer_id]).invoices
  end
end
