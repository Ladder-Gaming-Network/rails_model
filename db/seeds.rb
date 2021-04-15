# Lasser Gaming Network COSI 166B Spring 2021

require 'faker'
Follow.delete_all
Post.delete_all
User.delete_all
Viewcount.delete_all
Stream.delete_all

# Reset the Primary Keys
ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

num_gamers=10

#Seed Users
# Create Admin User
User.create(username:"admin", lastname:"smith",password:"123456", password_confirmation:"123456",admin_permissions:TRUE,timezone_code:0,description:"Admin User")
for i in 1..num_gamers do
    last_name=Faker::Name.last_name
    User.create(username:last_name+rand(100..999).to_s, lastname:last_name, stream_link:"twitch.com/"+rand(100..999).to_s, description:Faker::Quote.yoda, timezone_code:rand(-12..12),password:"123456", password_confirmation:"123456")
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
        # also have the parent_post be random and only for some of the posts
        Post.create(user_id:i, text:Faker::Quote.robin+" "+game, parent_post:rand(num_gamers/2))
        # create two viewcounts for the stream
        #Viewcount.create( stream_id:i, viewers:rand(100))
    end
end

# also set up the viewcounts

require "twitch-api"

@client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
@client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"

previous_view_count = 0

numPoints=0
stream_info= "dummy"
while numPoints<3 && stream_info do
    @twitch_client = Twitch::Client.new(
        client_id: @client_id,
        client_secret: @client_secret

        ## this is default
        # token_type: :application,

        ## this can be required by some Twitch end-points
        # scopes: scopes,

        ## if you already have one
        # access_token: access_token
    )

    username = "ludwig"
    twitch_id = @twitch_client.get_users({login: username}).data.first.id

    stream_info = @twitch_client.get_streams({user_id: twitch_id}).data.first
    if stream_info && stream_info.viewer_count != previous_view_count then
        puts("Data for Twitch streamer: " + username)
        puts("Title: " + stream_info.title)
        puts("View count: " + stream_info.viewer_count.to_s)
        previous_view_count = stream_info.viewer_count
        Viewcount.create!(stream_id:1, viewers:stream_info.viewer_count)
        numPoints+=1
    elsif stream_info
        puts("-----")
        sleep(60)
    end
end
if !stream_info
    puts "User was not online"
end