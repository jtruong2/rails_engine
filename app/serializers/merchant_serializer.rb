class MerchantSerializer < ActiveModel::Serializer
  attributes :id

  has_many :invoices
end
