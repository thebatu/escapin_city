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
category3 = Category.create!(name:"Cultural", photo: 'cultural.jpg')
category4 = Category.create!(name:"Historical", photo: 'historical.jpg')
category5 = Category.create!(name:"Arts", photo: 'art.jpg')
category6 = Category.create!(name:"Foods & Beverages", photo: 'foodie.jpg')
category7 = Category.create!(name:"Sports", photo: 'sport.jpg')
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


------------------------------------------------

the_hunt_data = {
  name: "Sweet Saint Emilion",
  city: "Bordeaux",
  mydistance: 10,
  difficulty: 2,
  user: User.first,
  category: Category.find_by_name("food&beverage"),
}
the_hunt = Hunt.create!(the_hunt_data)

checkpoints_data = [
  {
    lat: 44.891958,
    log:-0.156938,
    content: "Well done ! The “castel daou rey meaning the King’s Keep, is the only romanesque keep still intact in Gironde. Located inside the walls of the city, the building rests on a rocky massif isolated from all sides and dug in natural caves and quarries exploited since the Middle Ages. From the floor to the lower terrace at the top, there is height of 32 meters.",
    clue: "To begin the escape, you must find the oldest monument of this village and then walk on the top !"
  },
  {
    lat: 44.892910,
    log:-0.154929,
    content:"This fortification wall can also be considered as a ceremonial wall, prestige whose the first purpose would have been to show the power of the village more than to protect him. In any case that it should be requiered to pay a fee to enter in the intramural town, representinga new source of wealth.",
    clue: "The edifice you have to find was commissioned by England in the 12th century to protect prosperous Saint-Emilion's village."
  },
  {
    lat: 44.893681,
    log:-0.156756,
    content: "The most impressive church that stands out from the upper town is the Collegiate church. It’s not a fortunate coincidence. The religious community that lived in those walls between the 12th and the 18th century was a college of Canons following the rule of Saint Augustin and embodying the official religious institution. The etymology of the word canon helps us to understand their mission: it comes from the Ancient Greek “Kanôn” what means “the rule”.",
    clue: "The construction of the next monument started in 1110 at the request of the Archbishop Arnaud Géraud de Cabanac, good luck ! "
  },
  {
    lat: 44.893167,
    log:-0.156314,
    content: "The monolithic church is an underground religious building dugged in the early 12th century of gigantic proportions (38 metres long and 12 metres high). At the heart of the city, the monolithic church reminds the religious activity of the city in the Middle Ages and intrigues by its unusual design. If it shows itself in the eyes of the visitor by the position of a 68-meter-high bell tower, then it hides itself behind the elegance of three openings on the front and a Gothic portal often closed. Is that the church is as well surprising as fragile!",
    clue: "the monument you must find has gigantic proportions (38 metres long and 12 metres high)"
  },
  {
    lat: 44.893758,
    log: -0.156151,
    content: "Well done, have a little break and enjoy their tasty meals !",
    clue: "Find the oldest restaurant in the village and go for lunch with this voucher code : STEMILION17"
  },
  {
    lat: 44.895265,
    log:-0.154696,
    content: "Well done, Founded by Mrs. Lacroix, the convent and its 18 nuns had for main purpose to provide free education to girls from poor classes of the city and its Jurisdiction. The sisters managed to go up to 80 registered schoolgirls, figure which went down to 8 after the great epidemic of plague which, occurred 3 years after installation.",
    clue: "The sisters of the order of Saint-Ursule settle down in Saint-Emilion on June 1st, 1630. Find this place"
  },
  {
    lat: 44.907281,
    log: -0.165012,
    content: "By tradition, the Dominicans are part of the family of mendicant monks alongside the Franciscans. Their rule is based on the notion of individual poverty. For the architecture of the monastery match this ideal, certain rules had to be applied. The monastery buildings and the church should not exceed a certain height. This section of wall suggests that Saint-Emilion mendicant monks should not be as poor as their order demanded.",
    clue: "Be careful, you must  ride around 20 minutes to go to the huge monaster from XIIème siècle."
  },
  {
    lat: 44.908084,
    log: -0.142243,
    content: "Well done you finished the escape, enjoy the visit and don’t forget to try their amazing wines.",
    clue: "To finish you must ride until the nearest castel which is called The Champion"
  }
]

the_hunt.checkpoints.create!(checkpoints_data)





--------------------------------------------------
