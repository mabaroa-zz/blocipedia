require 'faker'

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    email: Faker::Internet.email, 
    username: Faker::Name.name, 
    password: password, 
    password_confirmation: password)
    u.skip_reconfirmation!
  



puts "Seed finished"
puts "#{User.count} users created"
end
