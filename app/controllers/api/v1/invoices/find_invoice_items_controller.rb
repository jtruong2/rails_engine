class Api::V1::Invoices::FindInvoiceItemsController < ApplicationController
  def show
    render json: Invoice.find(params[:invoice_id]).invoice_items
  end
end
