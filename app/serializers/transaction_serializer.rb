class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :credit_card_number

end
