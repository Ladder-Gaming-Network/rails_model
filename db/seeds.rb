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

#Seed Follows
30.times do
    r = Follow.create(user_id: 1, follower_id: 1)
    #r = Follow.create(user_id: User.all.sample.id, follower_id: User.all.sample.id)
end

#Seed Posts
for i in 1..30 do
    Post.create(gamer_id:i, text:Faker::Quote.robin+" "+Faker::Game.title, parent_post:rand(0..10))
end