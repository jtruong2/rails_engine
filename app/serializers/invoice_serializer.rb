class InvoiceSerializer < ActiveModel::Serializer
  attributes :id

  has_many :invoice_items
  has_many :transactions
  belongs_to :merchant
  belongs_to :customer
end
