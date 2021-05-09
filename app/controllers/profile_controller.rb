class ProfileController < ApplicationController
    def stream
        current_user
        @user = User.find(params[:id])

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
        current_user
        @user = User.find(params[:id])
    
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
      current_user
      @user = User.find(params[:id])
      #Feed: get posts that have user id = user.following
      @posts = []
      Post.where(user_id: @user.id).each do |post|
        @posts.append([post, @user])
      end
      @posts = @posts.sort{|a, b| b[0].created_at <=> a[0].created_at}
    end

end
