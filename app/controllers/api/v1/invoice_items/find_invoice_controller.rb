class Api::V1::InvoiceItems::FindInvoiceController < ApplicationController
  def show
    render json: InvoiceItem.find(params[:invoice_item_id]).invoice
  end
end
