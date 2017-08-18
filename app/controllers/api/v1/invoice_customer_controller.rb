class Api::V1::InvoiceCustomerController < ApplicationController
  def show
    render json: Invoice.find(params[:invoice_id]).customer
  end
end
