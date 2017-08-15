require 'csv'
desc 'import data to database from csv'
task :import => :environment do
  puts "Populating database with goodies"

  Rake::Task['db:reset'].invoke

  def seed_customers
    puts "seeding customers"
    customers = []
    contents = CSV.foreach(Rails.root + "lib/data/customers.csv", headers: true, header_converters: :symbol)
    contents.each { |row| customers << row.to_h}
    customers.each { |customer|
      Customer.create!(customer)
    }
    # seed_transactions
  end

  # def seed_transactions
  #   transactions = []
  #   contents = CSV.foreach(Rails.root + "lib/data/transactions.csv", headers: true, header_converters: :symbol)
  #   contents.each { |row| transactions << row.to_h}
  #   transactions.each { |transaction| Transaction.create!(customer)}
  #   seed_merchants
  # end
  #
  # def seed_merchants
  #   merchants = []
  #   contents = CSV.foreach(Rails.root + "lib/data/merchants.csv", headers: true, header_converters: :symbol)
  #   contents.each { |row| merchants << row.to_h}
  #   merchants.each { |merchant| Merchant.create!(merchant)}
  #   seed_invoices
  # end
  #
  # def seed_invoices
  #   invoices = []
  #   contents = CSV.foreach(Rails.root + "lib/data/invoices.csv", headers: true, header_converters: :symbol)
  #   contents.each { |row| values << row.to_h}
  #   invoices.each { |invoice| Invoice.create!(invoice)}
  #   seed_items
  # end
  #
  # def seed_items
  #   items = []
  #   contents = CSV.foreach(Rails.root + "lib/data/items.csv", headers: true, header_converters: :symbol)
  #   contents.each { |row| values << row.to_h}
  #   items.each { |item| Item.create!(item)}
  #   seed_invoice_items
  # end
  #
  # def seed_invoice_items
  #   invoice_items = []
  #   contents = CSV.foreach(Rails.root + "lib/data/invoice_items.csv", headers: true, header_converters: :symbol)
  #   contents.each { |row| values << row.to_h}
  #   invoice_items.each { |invoice_item| InvoiceItems.create!(invoice_item)}
  # end
  seed_customers
end
