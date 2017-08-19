class Api::V1::InvoiceItems::FindItemController < ApplicationController
  def show
    render json: InvoiceItem.find(params[:invoice_item_id]).item
  end
end
