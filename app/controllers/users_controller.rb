class UsersController < ApplicationController
include CableReady::Broadcaster
  using SessionsHelper
  require_relative("../controllers/scripts/twitch_data.rb")
  require_relative("../controllers/scripts/youtube_data.rb")

  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:show]

  def render_chart
    render json: Viewcount.where(stream_id:params[:stream_id]).pluck(:created_at, :viewers)
  end

  def begin_viewcount_sample
    #start job upon first stream tracking
    if Stream.where(tracked: true).count == 0 then
      ViewcountFetchWorker.perform_async
    end

    #mark current stream as tracked
    if !Stream.where(id: params[:stream_id]).first.tracked then
      stream = Stream.where(id: params[:stream_id]).first
      stream.tracked = true
      stream.save
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
    logger.error "TEST OUTPUT"
    logger.error  "****#{ENV['client_id']}****"
    logger.error  "****#{ENV['client_secret']}****"


    #Twitch
    @stream_status = "offline"
    if !@user.stream_link.nil? then
      @stream = TwitchData.get_stream(@user.id, @user.stream_link[11..])
      if !@stream.nil? then
        @stream_status = "online"
      end
    end

    #Youtube
    @channel = YoutubeData.get_channel_info(@user.youtube_id)

    #Follows
    @following = false
    if Follow.where(user_id: @user.id, follower_id: @current_user.id).exists? then
      @following = true
    end

    #Feed: get posts that have user id = user.following
    @feed_posts = []
    @current_user.following.each do |followed|
      Post.where(user_id: followed.id).each do |post|
        @feed_posts.append(post.text + " - " + followed.username)
      end
    end
    @online_users = TwitchData.get_live_followed(@current_user)

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
