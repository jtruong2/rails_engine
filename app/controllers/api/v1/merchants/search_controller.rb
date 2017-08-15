class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if safe_params.keys[0] == "name"
      render json: Merchant.find_by(safe_params)
    else

      a = Merchant.search_by_date(safe_params)
      
    end
  end

  private

  def safe_params
    params.permit(:name, :created_at, :updated_at)
  end
end
