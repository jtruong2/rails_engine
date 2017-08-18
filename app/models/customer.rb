class Customer < ApplicationRecord
  has_many :invoices

  def self.return_associated_transactions(id)
    joins(:invoices => [:transactions])
    .where("customer.id = ?", id)
    

  end
end
