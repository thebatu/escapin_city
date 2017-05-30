require 'faker'
include ActionView::Helpers::AssetUrlHelper

puts 'Destroying current Users database...'
puts 'Destroying current Hunts database...'
puts 'Destroying current Categories database...'
puts 'Destroying current Checkpoints database...'
puts 'Destroying current Participations database...'

models = [ User,Hunt, Category, Checkpoint, Participation ]


models.each do |model|
  model.destroy_all
end


puts 'Start seeding users...'
16.times do
  user = User.new(
    email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
    password: Faker::Internet.password
  )
  if user.save
    puts "> #{user.email} created"
  else
    puts "FAIL USERS SEED" * 5
  end
end


puts "-" * 100


category1 = Category.create!(name:"family", photo: 'familie.jpg')
category2 = Category.create!(name:"friends", photo: 'Friends.jpg')
category3 = Category.create!(name:"cultural", photo: 'cultural.jpeg')
category4 = Category.create!(name:"historical", photo: 'historical.jpeg')
category5 = Category.create!(name:"arts", photo: 'art.jpg')
category6 = Category.create!(name:"foods$beverages", photo: 'foodie.jpg')
category7 = Category.create!(name:"sports", photo: 'sport.jpeg')
category8 = Category.create!(name:"music", photo: 'music.jpg')



puts "-" * 100

cities = [
  '33000 Bordeaux',
  '75001 Paris',
  '13001 Marseille',
  '31000 Toulouse',
  '69001 Lyon',
  '54000 Nancy',
  '57000 Strasbourg',
  '44000 Nantes',
  '59000 Lille',
  '21000 Brest',
  '34000 Montpellier'
]
puts 'Start seeding Hunts...'
cities.each do |city|
  10.times do
  hunt = Hunt.new(
      name: Faker::App.name,
      city: city,
      mydistance: Faker::Number.between(1, 3),
      difficulty: Faker::Number.between(1, 5)
    )
    hunt.user = User.order('RANDOM()').first
    hunt.category = Category.order('RANDOM()').first
    if hunt.save
      puts "> #{hunt.name} created"
    else
      puts "FAIL HUNT SEED" * 5
    end
  end
end

puts "-" * 100

puts 'Start seeding Checkpoints...'
Hunt.all.each do |hunt|
  (6..12).to_a.sample.times do
    checkpoint = Checkpoint.new(
      lat: Faker::Address.latitude,
      log: Faker::Address.longitude,
      content: Faker::Hacker.say_something_smart,
      clue: Faker::Hacker.say_something_smart,
      hunt: hunt
    )
    if checkpoint.save
      puts "> #{checkpoint.lat} #{checkpoint.log} created"
    else
      puts "FAIL CHECKPOINTS SEED" * 5
    end
  end
puts "-" * 100
  puts 'Start seeding Participations...'
  (12..24).to_a.sample.times do
    participation = Participation.new(
      hunt: hunt,
      user: User.all.order('RANDOM()').first,
      checkpoint: Checkpoint.all.order('RANDOM()').first
    )
    if participation.save
      puts "> Participation created"
    else
      puts "FAIL PARTICIPATION SEED" * 5
    end
  end
end
