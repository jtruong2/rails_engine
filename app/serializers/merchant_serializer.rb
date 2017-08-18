class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :invoices
  has_many :items

end
