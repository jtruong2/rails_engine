FactoryGirl.define do
  factory :transaction do
    invoice nil
    credit_card_number 1
    credit_card_expiration_date "08/20"
    result "success"
  end
end
