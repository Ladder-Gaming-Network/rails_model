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
    UsersHelper.null_blank_input(@user)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to the app!"
      redirect_to '/profile?id='+@user.id.to_s
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    current_user
    respond_to do |format|
      if @user.update(user_params)
        UsersHelper.null_blank_input(@user)
        @user.save
        format.html { redirect_to "/profile?id=#{@current_user.id}", notice: "User was successfully updated." }
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
