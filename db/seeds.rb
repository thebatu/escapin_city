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


Category.create!(name:"Family", photo: 'familie.jpg')
Category.create!(name:"Friends", photo: 'Friends.jpg')
Category.create!(name:"Cultural", photo: 'cultural.jpg')
Category.create!(name:"Historical", photo: 'historical.jpg')
Category.create!(name:"Arts", photo: 'art.jpg')
Category.create!(name:"Foods & Beverages", photo: 'foodie.jpg')
Category.create!(name:"Sports", photo: 'sport.jpg')
Category.create!(name:"Music", photo: 'music.jpg')
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
    content: "The Jardin Public has been dear to the hearts of the Bordelais since its creation in 1746. A veritable "green lung" in the city centre, the 11 hectares of grass, trees, flowers, and plants also include a children's playground and the famous Guignol Guérin puppet show.",
    clue: "It's surrounded by a blue and yellow gates",
    photo: 'parc.jpg',
    description: "Find the most famous park of Bordeaux"
  },
  {
    lat: 44.845006,
    log:-0.574816,
    content:"The Place des Quinconces, located in Bordeaux, France, was laid out in 1820 on the site of Château Trompette and was intended to prevent rebellion against the city. Its guns were turned towards the centre. Its current shape (lengthened rectangle rounded off with a semicircle) was adopted in 1816. Trees were planted (in quincunxes, hence the name of the square) in 1818.",
    clue: "You'll find it on the largest square of the city",
    photo: 'quinconces.jpg',
    description: "Find the fountain with the horses in Bordeaux"
  },
  {
    lat: 44.842902,
    log:-0.577695,
    content: "Located in a prime position in the prestigious retail district 'The Golden Triangle', formed by the Cours de l'Intendance, the Cours Clemenceau and the Allées de Tourny, this shopping center is an ideal place to go sightseeing and shopping in an outsantding architectural setting.",
    clue: "It's in the quarter called the Golden triangle",
    photo: 'grands_hommes.jpg',
    description: "Find the market with a rounded form in Bordeaux "

  },
  {
    lat: 44.837667,
    log:-0.576767,
    content: "The cathedral was consecrated by Pope Urban II in 1096. Of the original Romanesque edifice, only a wall in the nave remains. The Royal Gate is from the early 13th century, while the rest of the construction is mostly from the 14th-15th centuries. The building is a national monument of France.",
    clue: "It's close to the maire's working place",
    photo: 'saint_andre.jpg',
    description: "Find the biggest religious monument of Bordeaux"

  },
  {
    lat: 44.838692,
    log: -0.568591,
    content: "Cailhau the door (its name recalls the accumulated stones at his feet by the Garonne which served to ballast the ship), built in the late fifteenth century, was part of the ramparts. She acted as a triumphal arch and defensive gate.",
    clue: "The style of this door is Gothic - Renaisssance",
    photo: 'caillaux.jpg',
    description: "Find the door in Bordeaux which is 35 meters high"

  },
  {
    lat: 44.841717,
    log:-0.569316
    content: "Located across from Place de la Bourse, between Quai de la Douane and Quai Louis XVIII, this spectacular pool, designed by landscape artist Michel Corajoud, alternates a mirror effect and artificial misting in an extraordinary way.",
    clue: "It's close to the quinconces place",
    photo: 'mirroir.jpg',
    description: "Find our most famous mirror "

  },
  {
    lat: 44.840180,
    log: -0.560146,
    content: "Overlooking the Place Stalingrad, opposite the stone bridge and the Garonne, this immense blue lion-like protective, was directed by Veilhan for a public commission in 2005, as part of the tramway works. Made of polystyrene composites, metal frame and polyester resin, it is a true visual landmark at the entrance of the Bastide.",
    clue: "It's 8 feet long and 6 meters high.",
    photo: 'lion.jpg',
    description: "Find the king of animals in Bordeaux "

  },
  {
    lat: 44.849376,
    log: -0.561242,
    content: "Located among the warehouses of a former military barracks in Bordeaux, DARWIN is an alternative space shared by 100 companies and 30 associations united around common goals: the reduction of their companies’ environmental footprints, creating new economic synergies and promoting urban cultures.",
    clue: "It is inside an eco-quarter of Bordeaux",
    photo: 'darwin.jpg',
    description: "Find the only vortex in Bordeaux"

  }
]

the_hunt.checkpoints.create!(checkpoints_data)
