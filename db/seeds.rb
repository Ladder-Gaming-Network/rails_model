# Lasser Gaming Network COSI 166B Spring 2021

require 'faker'

Game.delete_all
Follow.delete_all
Post.delete_all
User.delete_all
Viewcount.delete_all
Stream.delete_all
Interest.delete_all

# Reset the Primary Keys
ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

num_gamers=10

#Seed Users
# Create Admin User
User.create(username:"admin", lastname:"smith",password:"123456", password_confirmation:"123456",admin_permissions:TRUE,timezone_code:0,description:"Admin User")
twitch_links=["xqcow","sykkuno","monstercat","shroud","yvonnie"]
youtube_links=["UCmDTrq0LNgPodDOFZiSbsww","UCRAEUAmW9kletIzOxhpLRFw","UCJ6td3C9QlPO9O_J5dF4ZzA","UCoz3Kpu5lv-ALhR4h9bDvcw","UCgDvko7FcHndaS-QoLJw_PA"]

for i in 1..num_gamers do
    last_name=Faker::Name.last_name
    User.create(username:last_name+rand(100..999).to_s, lastname:last_name, stream_link:"twitch.com/"+twitch_links[i%twitch_links.length], description:Faker::Quote.yoda, 
        timezone_code:rand(-12..12),password:"123456", password_confirmation:"123456",youtube_id:youtube_links[i%youtube_links.length])
end

#Seed Follows, every gamer will follow another gamer
for i in 1..num_gamers do
    #r = Follow.create(user_id: i, follower_id: num_gamers-i+1)
    #random=random_no_repeat(i,1,num_gamers)
    random=([*1..num_gamers] - [i]).sample
    r = Follow.create(user_id: random, follower_id: i)
    random=([*1..num_gamers] - [i,random]).sample
    r = Follow.create(user_id: random, follower_id: i)
end

#Seed Posts, stream, and viewcount
for i in 0..num_gamers do
    game=Faker::Game.title
    # each user will have a stream
    Stream.create(user_id:i, title:game)
    for j in 0..1 do
        game=Faker::Game.title
        # also have the parent_post be random and only for some of the posts
        Post.create(user_id:i, text:Faker::Quote.robin+" "+game, parent_post:rand(num_gamers/2))
        Interest.create(user_id:i, interest:game)
    end
end
# Seed games usig steam web api
data = SteamWebApi::Game.all
data.games[0..150].each {|game|
    name=game["name"]
    # rule out empty or test names
    if !name.strip.empty? and !name.include? "test"
        Game.create(name:game["name"],code:game["appid"])
    end
}
