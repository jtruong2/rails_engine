require 'date'

class Merchant < ApplicationRecord

  def self.search_by_date(date.to_h)

    search_date = DateTime.parse(date.values[0])
    Merchant.find_by({date.keys[0] => search_date})
    
  end
end
