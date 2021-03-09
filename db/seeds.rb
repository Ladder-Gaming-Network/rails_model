# Lasser Gaming Network COSI 166B Spring 2021

require 'faker'
Follow.delete_all
Post.delete_all
User.delete_all

# Reset the Primary Keys
ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

num_gamers=10

#Seed Users
for i in 0..num_gamers do
    last_name=Faker::Name.last_name
    User.create(username:last_name+rand(100..999).to_s, lastname:last_name, stream_link:"twitch.com/"+rand(100..999).to_s, description:Faker::Quote.yoda, timezone_code:rand(-12..12))
end

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