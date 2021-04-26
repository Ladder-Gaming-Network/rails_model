class UsersController < ApplicationController
include CableReady::Broadcaster

  require "twitch-api"
  using SessionsHelper

  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:show]

  def render_chart
    render json: Viewcount.where(stream_id:params[:stream_id]).pluck(:created_at, :viewers)
  end

  def begin_viewcount_sample
    #begin getting viewcounts from twitch
    if !Stream.where(id: params[:stream_id]).first.tracked then
      stream = Stream.where(id: params[:stream_id]).first
      stream.tracked = true
      stream.save
      #FetchViewcountsJob.perform_later()
    end
  end

  # GET /users or /users.json
  def index
    if $new_users_search
      @users=$users
      $new_users_search=FALSE
    else
      @users = User.all
    end
  end

  def counter
    @count ||= session[:count]
  end

  # GET /users/1 or /users/1.json
  def show

    current_user
    @user = User.find(params[:id])
    @stream_status = "offline"

    #get twitch stream data, if link available
    if !@user.stream_link.nil? then

      #link to twitch api via gem
      client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
      client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"
      twitch_client = Twitch::Client.new(
          client_id: client_id,
          client_secret: client_secret
      )
      username = @user.stream_link[11..]
      user_fetch = twitch_client.get_users({login: username}).data.first
      if !user_fetch.nil? then
        twitch_id = user_fetch.id
        stream_info = twitch_client.get_streams({user_id: twitch_id}).data.first
      end

      #see if stream is active
      if (!stream_info.nil?) then
        @stream_status = "online"
        fetched_stream = Stream.where(id:stream_info.id).first
        if fetched_stream.nil? then
          #if id has changed, destroy last stream + viewcounts
          stream_to_delete = Stream.where(user_id:@user.id).first
          if !stream_to_delete.nil? then
            Viewcount.where(stream_id:stream_to_delete.id).destroy_all
            stream_to_delete.destroy
          end
          @stream = Stream.create(id:stream_info.id, user_id:@user.id, title:stream_info.title)
        else
          #otherwise, just continue
          @stream = fetched_stream
        end
      end
    end

    #get youtube channel data

    #link to youtubeapi via gem
    api_key = "AIzaSyDtW_pu7jl1TwQb6bG0fkphbPuLKXxpdA8"
    Yt.configure do |config|
      config.api_key = api_key
    end

    #temporary default: MrBeast
    @channel = Yt::Channel.new id: @user.youtube_id

    # will use for editing
    # if !current_user?(@user)
    #   flash[:danger]="You can only view your own user information!"
    #   redirect_to "/users/#{current_user.id}"
    # end
    @follows = Follow.all
    @following = false
    if Follow.where(user_id: @user.id, follower_id: @current_user.id).exists? then
      @following = true
    end
    #get posts that have user id = user.following
    @feed_posts = []
    @current_user.following.each do |followed|
      Post.where(user_id: followed.id).each do |post|
        @feed_posts.append(post.text + " - " + followed.username)
      end
    end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to the app!"
      redirect_to @user
    else
      render 'new'
    end
  end
end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :lastname, :stream_link, :description, :timezone_code,:password,:password_confirmation,:youtube_id)
    end
end
