User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar87",
             password_confirmation: "foobar87",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password87"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::WorldOfWarcraft.quote
  users.each { |user| user.microposts.create!(content: content) }
end