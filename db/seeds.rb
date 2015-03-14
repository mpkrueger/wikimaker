require 'faker'

# Create Users
10.times do
  User.create!(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: ["standard", "admin", "premium"].sample
  )
end
users = User.all

# Create Wikis
25.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: [true, false].sample
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."