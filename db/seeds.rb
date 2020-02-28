# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "banana"  


User.destroy_all 
Workout.destroy_all 
ClassSchedule.destroy_all
SocialEvent.destroy_all
Trainer.destroy_all 
Section.destroy_all
FoodItem.destroy_all

super_user = User.create( 
    first_name: "Steph", 
    last_name: "Me", 
    email: "steph_war@yahoo.ca", 
    password: PASSWORD,
    is_admin: true,
    program: "Admin",
    meals: 0,
    food_account: 0.00,
    role: "admin"
) 

#Users (Trainers):
20.times do 
    first_name = Faker::Name.first_name 
    last_name = Faker::Name.last_name 
    User.create( 
        first_name: first_name, 
        last_name: last_name,  
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com", 
        password: PASSWORD ,
        program: "Trainer",
        meals: 0,
        food_account: 0.00,
        role: "trainer",
    )  
end

#Users (Guests):
10.times do 
    first_name = Faker::Name.first_name 
    last_name = Faker::Name.last_name 
    User.create( 
        first_name: first_name, 
        last_name: last_name,  
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com", 
        password: PASSWORD ,
        program: "Muay Thai",
        meals: 0,
        food_account: 0.00,
        role: "guest",
    )  
end 

users = User.all 

#Menu Sections
    Section.create( name: "Breakfast")
    Section.create( name: "Meals")
    Section.create( name: "Drinks")
    Section.create( name: "Shakes")
end

sections = Section.all

1000.times do
    user = users.sample
    p = Product.create(
        title: Faker::Coffee.blend_name,
        description: Faker::Coffee.notes,
        price: Faker::Number.decimal(l_digits: 2),
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
    if p.valid?
        rand(0..15).times.each do
            user = users.sample
            r = Review.create(
                body: Faker::Verb.past_participle,
                rating: Faker::Number.within(range: 1..5),
                user_id: user.id,
                product: p
            )
            r.likers = users.shuffle.slice(0..rand(users.count)) if r.valid?
            p.tags = tags.shuffle.slice(0..rand(5))
            p.fans = users.shuffle.slice(0..rand(users.count))
            if r.valid?
                users.shuffle.slice(0..rand(users.count)).each do |user|
                    Vote.create(
                      review: r,
                      user: user,
                      is_up: [true, false].sample
                    )
                end
            end
        end
    end
end

puts Cowsay.say("Generated #{Product.count} products", :cow)
puts Cowsay.say("Generated #{Review.count} reviews", :frogs)
puts Cowsay.say("Generated #{Like.count} Likes", :ghostbusters)
puts Cowsay.say("Generated #{Favourite.count} Favourites", :dragon)
puts Cowsay.say("Generated #{Tag.count} tags", :kitty)
puts Cowsay.say("Created #{Vote.count} votes", :turtle)
puts Cowsay.say("Created #{User.count} users", :tux)  
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"
