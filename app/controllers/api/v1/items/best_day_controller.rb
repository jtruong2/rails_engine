class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: Invoice.best_day(params[:item_id]), serializer: BestdaySerializer
  end
end
