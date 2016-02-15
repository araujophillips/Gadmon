namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Customer, ShippingAddress, Product, ProductDetail, Price, Provider, Purchase, PurchaseDetail].each(&:delete_all)

    
    Customer.populate 40 do |customer|
      customer.name = Faker::Name.name
      customer.email = Faker::Internet.email
      customer.phone = Faker::PhoneNumber.phone_number
      customer.username = Faker::Internet.user_name
      customer.comment = Faker::Lorem.sentences(3, true)
      ShippingAddress.populate Random.rand(0...3) do |shipping_address|
        shipping_address.customer_id = customer.id
        shipping_address.office = 0
        shipping_address.company = ''
        shipping_address.address = Faker::Address.street_address+' '+Faker::Address.street_name+' '+Faker::Address.secondary_address+' '+Faker::Address.secondary_address
        shipping_address.municipality = Faker::Address.city
        shipping_address.city = Faker::Address.city
        shipping_address.state = Faker::Address.state
        shipping_address.comment = Faker::Lorem.sentence(3, true)
      end
    end

    Product.populate 300 do |product|
      product.name = Faker::Commerce.product_name
      product.published = Random.rand(2)
      ProductDetail.populate Random.rand(1...40) do |product_detail|
        product_detail.product_id = product.id
        product_detail.serial = Faker::Code.isbn
        product_detail.comment = Faker::Lorem.sentence(6, true)
        product_detail.status = Random.rand(1...3)
      end
      Price.populate Random.rand(1...10) do |price|
        price.product_id = product.id
        price.price = Faker::Commerce.price(500...50000)
        price.comment = Faker::Lorem.sentence(10, true)
      end
    end

    Provider.populate 50 do |provider|
      provider.name = Faker::Company.name
      provider.type_id = Random.rand(2...6)
      provider.email = Faker::Internet.email
      provider.phone = Faker::PhoneNumber.phone_number
      provider.address = Faker::Address.street_address+' '+Faker::Address.street_name+' '+Faker::Address.secondary_address+', '+Faker::Address.secondary_address+', '+Faker::Address.city+', '+Faker::Address.state
      provider.rif = 'J-'+Faker::Company.swedish_organisation_number
      provider.comment = Faker::Lorem.sentence(5, true)
    end

    Purchase.populate 100 do |purchase|
      purchase.provider_id = Random.rand(1...50)
      purchase.subtotal = Faker::Commerce.price(500...50000)
      purchase.tax = purchase.subtotal * 0.12
      purchase.total = purchase.subtotal + purchase.tax
      purchase.comment = Faker::Lorem.sentence(5, true)
      i = Random.rand(0...10)
      line = 1
      PurchaseDetail.populate i do |purchase_detail|
        purchase_detail.purchase_id = purchase.id
        purchase_detail.line = line
        purchase_detail.name = Faker::Commerce.product_name
        purchase_detail.price = purchase.subtotal / i
        line = line + 1
      end
    end
  end
end