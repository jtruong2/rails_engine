class BestdaySerializer < ActiveModel::Serializer
  attributes :best_day

  def best_day
    object[0]["created_at"]
  end
end
