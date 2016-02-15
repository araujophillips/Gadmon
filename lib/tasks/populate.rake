namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Customer].each(&:delete_all)
    
    Customer.populate 40 do |customer|
      customer.name = Faker::Name.name
      customer.email = Faker::Internet.email
      customer.phone = Faker::PhoneNumber.phone_number
      customer.username = Faker::Internet.user_name
      customer.comment = Faker::Lorem.sentences(3, true)
    end

  end
end