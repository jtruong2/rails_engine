class Merchant < ApplicationRecord
  has_many :invoices

  def self.top_merchants_by_revenue(limit)
    where("SELECT merchants, revenue FROM
    (SELECT m.name AS merchants, sum(inv_item.unit_price * inv_item.quantity)
    AS revenue FROM merchants m INNER JOIN items ON m.id = items.merchant_id
    INNER JOIN invoice_items inv_item ON items.id = inv_item.item_id
    GROUP BY m.id) AS merch_rev
    ORDER BY revenue DESC LIMIT ?;", limit)
  end
end
