class ProfileController < ApplicationController
  require_relative("../controllers/scripts/twitch_data.rb")
  require_relative("../controllers/scripts/youtube_data.rb")
  before_action :logged_in_user
  before_action :set_user, except: [:feed]

    def set_user
      @user = User.find(params[:id])
    end

    def stream
        #Twitch
        @stream_status = "offline"
        if !@user.stream_link.nil? then
          @stream = TwitchData.get_stream(@user.id, @user.stream_link[11..])
          if !@stream.nil? then
            @stream_status = "online"
          end
        end
    end

    def show
        #Youtube
        @channel = YoutubeData.get_channel_info(@user.youtube_id)
    
        #Follows
        @following = false
        if Follow.where(user_id: @user.id, follower_id: @current_user.id).exists? then
          @following = true
        end
    end

    def feed
      @user = current_user
        #Feed: get posts that have user id = user.following
        @feed_posts = []
        @current_user.following.each do |followed|
            Post.where(user_id: followed.id).each do |post|
              @feed_posts.append([post, followed])
            end
        end
        @online_users = TwitchData.get_live_followed(@current_user)
        @feed_posts = @feed_posts.sort{|a, b| b[0].created_at <=> a[0].created_at}
    end

    def posts
      @posts=items_collection(Post)
    end

    def interests
     @interests=items_collection(Interest)
    end

    def items_collection(database)
      #Feed: get itmes that have the current user's id
      @items = []
      database.where(user_id: @user.id).each do |item|
        @items.append([item, @user])
      end
      @items.sort{|a, b| b[0].created_at <=> a[0].created_at}
    end

end
