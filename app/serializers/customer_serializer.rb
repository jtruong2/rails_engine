class CustomerSerializer < ActiveModel::Serializer
  attributes :id

  has_many :invoices
end
