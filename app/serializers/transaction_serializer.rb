class TransactionSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :invoice
end
