require 'faker'

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
    puts "FAIL FAIL FAIL"
  end
end


puts 'Start seeding categories...'
categories_list = %w(family friends food&beverage cultural sports music historical arts)
16.times do
  category = Category.new(
  name: categories_list.sample
  )
  if category.save
    puts "> #{category.name} created"
  else
    puts "FAIL FAIL FAIL"
  end
end


puts 'Start seeding Hunts...'
16.times do
hunt = Hunt.new(
    name: Faker::App.name,
    city: Faker::Address.city,
    distance: Faker::Number.between(1, 3),
    difficulty: Faker::Number.between(1, 5)
  )
  hunt.user = User.all.order('RANDOM()').first
  hunt.category = Category.all.order('RANDOM()').first
  if hunt.save
    puts "> #{hunt.name} created"
  else
    puts "FAIL FAIL FAIL"
  end
end



puts 'Start seeding Checkpoints...'
16.times do
  checkpoint = Checkpoint.new(
    lat: Faker::Address.latitude,
    log: Faker::Address.longitude,
    content: Faker::Hacker.say_something_smart,
    clue: Faker::Hacker.say_something_smart
  )
  checkpoint.hunt = Hunt.all.order('RANDOM()').first
  if checkpoint.save
    puts "> #{checkpoint.lat} #{checkpoint.log} created"
  else
    puts "FAIL FAIL FAIL"
  end
end

puts 'Start seeding Participations...'
16.times do
    participation = Participation.new(
    )
    participation.user = User.all.order('RANDOM()').first
    participation.hunt = Hunt.all.order('RANDOM()').first
    participation.checkpoint = Checkpoint.all.order('RANDOM()').first
    if participation.save
      puts "> Participation created"
    else
      puts "FAIL FAIL FAIL"
    end
end
