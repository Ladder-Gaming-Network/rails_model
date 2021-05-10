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
# seed users with real gamer information
twitch_links= ["cdawgva",                  "starsmitten",             "tenjoramu",               "annacramling",                 "backgroundgaming_",       "sykkuno",                 "monstercat",              "shroud",                                                                                      "yvonnie",                            "xqcow"]
youtube_links=["UCPsZ_0SkFdi551iYTG04R2g", "UCblGuuU5c-CYqasi25xXXVQ",nil,                       "UCOVfq3NNYjlYCz1iou69FwQ",     "UC9mSaitKgNZJkKfxeziQC-g","UCRAEUAmW9kletIzOxhpLRFw","UCJ6td3C9QlPO9O_J5dF4ZzA","UCoz3Kpu5lv-ALhR4h9bDvcw",                                                                    "UCgDvko7FcHndaS-QoLJw_PA",           "UCmDTrq0LNgPodDOFZiSbsww"]
descriptions= ["I'm that guy",             "I play TFT sometimes.",   "てんじょらむ",             "Instructional chess streamer!","24/7 background games!",  "what is up guys",         "24/7 gamer music",        "Canadian streamer, YouTuber and former professional Counter-Strike: Global Offensive player.","Challenger league player...someday.","The coolest French Canadian on Twitch"]

for i in 1..num_gamers do
    twitch_link=twitch_links[i%twitch_links.length]
    User.create(username:twitch_link, lastname:twitch_link, stream_link:"twitch.com/"+twitch_link, description:descriptions[i%descriptions.length],
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
data.games[0..300].each {|game|
    name=game["name"].downcase
    game_api=SteamWebApi::Game.new(game["appid"])
    achievments=game_api.achievement_percentages.achievements
    news=game_api.news.news_items
    # rule out empty or test names
    if !name.strip.empty? and !achievments.nil? and !news.nil? and !name.include? "hentai" and !name.include? "sex" and !name.include? "fap"
        # use the original name to ignore downcasing
        Game.create(name:game["name"],code:game["appid"])
    end
}
