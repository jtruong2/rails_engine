class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status

  has_many :invoice_items
  has_many :transactions
end
