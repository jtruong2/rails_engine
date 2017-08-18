class Api::V1::InvItemsController < ApplicationController
  def show
    render json: Invoice.find(params[:invoice_id]).items
  end
end
