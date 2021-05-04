[1mdiff --git a/README.md b/README.md[m
[1mindex b77fb33..b8254d8 100644[m
[1m--- a/README.md[m
[1m+++ b/README.md[m
[36m@@ -1,6 +1,6 @@[m
 Jacob Smith, Christopher Tam, Nicolas Ramirez[m
 Cosi 166B[m
[31m-4/4/21[m
[32m+[m[32m5/4/21[m[41m[m
 [m
 GitHub link: https://github.com/Ladder-Gaming-Network/rails_model[m
 [m
[1mdiff --git a/app/controllers/search_controller.rb b/app/controllers/search_controller.rb[m
[1mindex 6d7bcfc..41386c1 100644[m
[1m--- a/app/controllers/search_controller.rb[m
[1m+++ b/app/controllers/search_controller.rb[m
[36m@@ -1,6 +1,7 @@[m
 class SearchController < ApplicationController[m
     def search()[m
         @users=User.all()[m
[32m+[m[32m        debugger[m
         if !params["query"].blank?[m
           searched_users=User.search(params["query"])[m
           if searched_users.size>0[m
[1mdiff --git a/db/seeds.rb b/db/seeds.rb[m
[1mindex 805336d..120a193 100644[m
[1m--- a/db/seeds.rb[m
[1m+++ b/db/seeds.rb[m
[36m@@ -2,61 +2,64 @@[m
 [m
 require 'faker'[m
 [m
[31m-Game.delete_all[m
[31m-Follow.delete_all[m
[31m-Post.delete_all[m
[31m-User.delete_all[m
[31m-Viewcount.delete_all[m
[31m-Stream.delete_all[m
[31m-Interest.delete_all[m
[31m-[m
[31m-# Reset the Primary Keys[m
[31m-ActiveRecord::Base.connection.tables.each do |t|[m
[31m-    ActiveRecord::Base.connection.reset_pk_sequence!(t)[m
[31m-  end[m
[31m-[m
[31m-num_gamers=10[m
[31m-[m
[31m-#Seed Users[m
[31m-# Create Admin User[m
[31m-User.create(username:"admin", lastname:"smith",password:"123456", password_confirmation:"123456",admin_permissions:TRUE,timezone_code:0,description:"Admin User")[m
[31m-twitch_links=["xqcow","sykkuno","monstercat","shroud","yvonnie"][m
[31m-youtube_links=["UCmDTrq0LNgPodDOFZiSbsww","UCRAEUAmW9kletIzOxhpLRFw","UCJ6td3C9QlPO9O_J5dF4ZzA","UCoz3Kpu5lv-ALhR4h9bDvcw","UCgDvko7FcHndaS-QoLJw_PA"][m
[31m-[m
[31m-for i in 1..num_gamers do[m
[31m-    last_name=Faker::Name.last_name[m
[31m-    User.create(username:last_name+rand(100..999).to_s, lastname:last_name, stream_link:"twitch.com/"+twitch_links[i%twitch_links.length], description:Faker::Quote.yoda, [m
[31m-        timezone_code:rand(-12..12),password:"123456", password_confirmation:"123456",youtube_id:youtube_links[i%youtube_links.length])[m
[31m-end[m
[31m-[m
[31m-#Seed Follows, every gamer will follow another gamer[m
[31m-for i in 1..num_gamers do[m
[31m-    #r = Follow.create(user_id: i, follower_id: num_gamers-i+1)[m
[31m-    #random=random_no_repeat(i,1,num_gamers)[m
[31m-    random=([*1..num_gamers] - [i]).sample[m
[31m-    r = Follow.create(user_id: random, follower_id: i)[m
[31m-    random=([*1..num_gamers] - [i,random]).sample[m
[31m-    r = Follow.create(user_id: random, follower_id: i)[m
[31m-end[m
[31m-[m
[31m-#Seed Posts, stream, and viewcount[m
[31m-for i in 0..num_gamers do[m
[31m-    game=Faker::Game.title[m
[31m-    # each user will have a stream[m
[31m-    Stream.create(user_id:i, title:game)[m
[31m-    for j in 0..1 do[m
[31m-        game=Faker::Game.title[m
[31m-        # also have the parent_post be random and only for some of the posts[m
[31m-        Post.create(user_id:i, text:Faker::Quote.robin+" "+game, parent_post:rand(num_gamers/2))[m
[31m-        Interest.create(user_id:i, interest:game)[m
[31m-    end[m
[31m-end[m
[32m+[m[32m# Game.delete_all[m
[32m+[m[32m# Follow.delete_all[m
[32m+[m[32m# Post.delete_all[m
[32m+[m[32m# User.delete_all[m
[32m+[m[32m# Viewcount.delete_all[m
[32m+[m[32m# Stream.delete_all[m
[32m+[m[32m# Interest.delete_all[m
[32m+[m
[32m+[m[32m# # Reset the Primary Keys[m
[32m+[m[32m# ActiveRecord::Base.connection.tables.each do |t|[m
[32m+[m[32m#     ActiveRecord::Base.connection.reset_pk_sequence!(t)[m
[32m+[m[32m#   end[m
[32m+[m
[32m+[m[32m# num_gamers=10[m
[32m+[m
[32m+[m[32m# #Seed Users[m
[32m+[m[32m# # Create Admin User[m
[32m+[m[32m# User.create(username:"admin", lastname:"smith",password:"123456", password_confirmation:"123456",admin_permissions:TRUE,timezone_code:0,description:"Admin User")[m
[32m+[m[32m# twitch_links=["xqcow","sykkuno","monstercat","shroud","yvonnie"][m
[32m+[m[32m# youtube_links=["UCmDTrq0LNgPodDOFZiSbsww","UCRAEUAmW9kletIzOxhpLRFw","UCJ6td3C9QlPO9O_J5dF4ZzA","UCoz3Kpu5lv-ALhR4h9bDvcw","UCgDvko7FcHndaS-QoLJw_PA"][m
[32m+[m
[32m+[m[32m# for i in 1..num_gamers do[m
[32m+[m[32m#     last_name=Faker::Name.last_name[m
[32m+[m[32m#     User.create(username:last_name+rand(100..999).to_s, lastname:last_name, stream_link:"twitch.com/"+twitch_links[i%twitch_links.length], description:Faker::Quote.yoda,[m[41m [m
[32m+[m[32m#         timezone_code:rand(-12..12),password:"123456", password_confirmation:"123456",youtube_id:youtube_links[i%youtube_links.length])[m
[32m+[m[32m# end[m
[32m+[m
[32m+[m[32m# #Seed Follows, every gamer will follow another gamer[m
[32m+[m[32m# for i in 1..num_gamers do[m
[32m+[m[32m#     #r = Follow.create(user_id: i, follower_id: num_gamers-i+1)[m
[32m+[m[32m#     #random=random_no_repeat(i,1,num_gamers)[m
[32m+[m[32m#     random=([*1..num_gamers] - [i]).sample[m
[32m+[m[32m#     r = Follow.create(user_id: random, follower_id: i)[m
[32m+[m[32m#     random=([*1..num_gamers] - [i,random]).sample[m
[32m+[m[32m#     r = Follow.create(user_id: random, follower_id: i)[m
[32m+[m[32m# end[m
[32m+[m
[32m+[m[32m# #Seed Posts, stream, and viewcount[m
[32m+[m[32m# for i in 0..num_gamers do[m
[32m+[m[32m#     game=Faker::Game.title[m
[32m+[m[32m#     # each user will have a stream[m
[32m+[m[32m#     Stream.create(user_id:i, title:game)[m
[32m+[m[32m#     for j in 0..1 do[m
[32m+[m[32m#         game=Faker::Game.title[m
[32m+[m[32m#         # also have the parent_post be random and only for some of the posts[m
[32m+[m[32m#         Post.create(user_id:i, text:Faker::Quote.robin+" "+game, parent_post:rand(num_gamers/2))[m
[32m+[m[32m#         Interest.create(user_id:i, interest:game)[m
[32m+[m[32m#     end[m
[32m+[m[32m# end[m
 # Seed games usig steam web api[m
 data = SteamWebApi::Game.all[m
[31m-data.games[0..150].each {|game|[m
[32m+[m[32mdata.games[0..300].each {|game|[m
     name=game["name"][m
[32m+[m[32m    game_api=SteamWebApi::Game.new(game["appid"])[m
[32m+[m[32m    achievments=game_api.achievement_percentages.achievements[m
[32m+[m[32m    news=game_api.news.news_items[m
     # rule out empty or test names[m
[31m-    if !name.strip.empty? and !name.include? "test"[m
[32m+[m[32m    if !name.strip.empty? and !achievments.nil? and !news.nil? and !name.include? "hentai"[m
         Game.create(name:game["name"],code:game["appid"])[m
     end[m
 }[m
