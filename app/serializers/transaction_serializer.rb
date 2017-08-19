class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :credit_card_number, :invoice_id

  def credit_card_number
    object.credit_card_number.to_s
  end

end
