class ItemSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :merchant
  belongs_to :invoice_item
end
