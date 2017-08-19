require 'csv'
namespace :app do
  desc 'import data to database from csv'
  task :import => :environment do
    puts "Populating database with goodies"

    Rake::Task['db:reset'].invoke

    def from_csv(file_path)
      values = []
      contents = CSV.open(file_path, headers: true, header_converters: :symbol)
      contents.each {|row| values << row.to_h }
      values
    end

    def seed_customers
      customers = []
      csv = from_csv(Rails.root + "lib/data/customers.csv")
      csv.each { |row| customers << row.to_h}
      customers.each { |customer| Customer.create!(customer)}
    end

    def seed_merchants
      merchants = []
      csv = from_csv(Rails.root + "lib/data/merchants.csv")
      csv.each { |row| merchants << row.to_h}
      merchants.each { |merchant| Merchant.create!(merchant)}
    end

    def seed_invoices
      invoices = []
      csv = from_csv(Rails.root + "lib/data/invoices.csv")
      csv.each { |row| invoices << row.to_h}
      invoices.each { |invoice| Invoice.create!(invoice)}
    end

    def seed_transactions
      transactions = []
      csv = from_csv(Rails.root + "lib/data/transactions.csv")
      csv.each { |row| transactions << row.to_h}
      transactions.each { |transaction| Transaction.create!(transaction)}
    end

    def seed_items
      items = []
      csv = from_csv(Rails.root + "lib/data/items.csv")
      csv.each { |row| items << row.to_h}
      items.each { |item| Item.create!(item)}
    end

    def seed_invoice_items
      invoice_items = []
      csv = from_csv(Rails.root + "lib/data/invoice_items.csv")
      csv.each { |row| invoice_items << row.to_h}
      invoice_items.each do |invoice_item|
        InvoiceItem.create!(invoice_item)
      end
    end

    puts "seeding customers"
    seed_customers

    puts "seeding merchants"
    seed_merchants

    puts "seeding invoices"
    seed_invoices

    puts "seeding transactions"
    seed_transactions

    puts "seeding items"
    seed_items

    puts "seeding invoice_items"
    seed_invoice_items
  end
end
