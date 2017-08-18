class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :item
  belongs_to :invoice
end
