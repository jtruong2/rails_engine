class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object.values[0] / 100).to_s
  end
end
