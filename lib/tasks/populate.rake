namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Customer, ShippingAddress].each(&:delete_all)

    
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

  end
end