# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
Follow.delete_all
Post.delete_all

# Reset the Primary Keys
ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

num_gamers=10

#Seed Follows, every gamer will follow another gamer
for i in 1..num_gamers do
    r = Follow.create(user_id: i, follower_id: num_gamers-i+1)
    #r = Follow.create(user_id: User.all.sample.id, follower_id: User.all.sample.id)
end

#Seed Posts, every gamer will have two posts
for i in 0..num_gamers*2-1 do
    # also have the parent_post be random and only for some of the posts
    Post.create(gamer_id:i/2+1, text:Faker::Quote.robin+" "+Faker::Game.title, parent_post:rand(num_gamers/2))
end