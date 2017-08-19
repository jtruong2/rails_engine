class SingleMerchantSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object / 100).to_s
  end
end
