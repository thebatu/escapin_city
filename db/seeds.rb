require 'faker'
include ActionView::Helpers::AssetUrlHelper

puts 'Destroying current Users database...'
puts 'Destroying current Hunts database...'
puts 'Destroying current Categories database...'
puts 'Destroying current Checkpoints database...'
puts 'Destroying current Participations database...'

models = [
  Participation,
  Checkpoint,
  Hunt,
  User,
  Category
]

models.each do |model|
  model.destroy_all
end


puts 'Start seeding users...'
10.times do
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

User.create!(email: "toto@toto.com", password: "totototo");

puts "-" * 100


category1 = Category.create!(name:"Family", photo: 'familie.jpg')
category2 = Category.create!(name:"Friends", photo: 'Friends.jpg')
category3 = Category.create!(name:"Cultural", photo: 'cultural.jpeg')
category4 = Category.create!(name:"Historical", photo: 'historical.jpeg')
category5 = Category.create!(name:"Arts", photo: 'art.jpg')
category6 = Category.create!(name:"Foods & Beverages", photo: 'foodie.jpg')
category7 = Category.create!(name:"Sports", photo: 'sport.jpeg')
category8 = Category.create!(name:"Music", photo: 'music.jpg')
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
  2.times do
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
  (3..6).to_a.sample.times do
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
  (6..12).to_a.sample.times do
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



the_hunt_data = {
  name: "Mystic Burdigala",
  city: "Bordeaux",
  mydistance: 5,
  difficulty: 3,
  user: User.first,
  category: Category.find_by_name("Cultural")
}
the_hunt = Hunt.create!(the_hunt_data)

checkpoints_data = [
  {
    lat: 44.849803,
    log:-0.578613,
    content: "key was made by Alex the first",
    clue: "find the key next to the fountain"
  },
  {
    lat: 44.849803,
    log:-0.574634,
    content:"Castle is the first to be built in this area",
    clue: "find the old castle with lion statu"
  },
  {
    lat: 44.841032,
    log:-0.580720,
    content: " 300 people died here by the black plague",
    clue: "find traces of old people "
  },
  {
    lat: 44.837667,
    log:-0.576767,
    content: "the castle is the biggest in Gironde",
    clue: "find the huge castle"
  },
  {
    lat: 44.838568,
    log: -0.572869,
    content: "this famouse horse was ridden by Alexander the great",
    clue: "look for the horse"
  },
  {
    lat: 44.836683,
    log:-0.566696,
    content: "this tree is the oldest in the reigon",
    clue: " look for an old tree!"
  },
  {
    lat: 44.840180,
    log: -0.560146,
    content: "this roof-top is standing still since 1863",
    clue: "find the red roof-top"
  },
  {
    lat: 44.849376,
    log: -0.561242,
    content: "the huge sand dune is part of the structure",
    clue: "find the yellow sand"
  }
]

the_hunt.checkpoints.create!(checkpoints_data)
