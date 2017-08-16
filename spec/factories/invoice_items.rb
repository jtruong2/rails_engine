FactoryGirl.define do
  factory :invoice_item do
    item nil
    invoice nil
    sequence(:quantity) { |i| "#{i}"}
    sequence(:unit_price) {|i| "#{i}"}
  end
end
