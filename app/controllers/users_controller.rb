class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:show]

  # GET /users or /users.json
  def index
    @users = User.all
    if !admin?
      flash[:danger]="Only the Admin can see that!"
      redirect_to ""
    end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    # will use for editing
    # if !current_user?(@user)
    #   flash[:danger]="You can only view your own user information!"
    #   redirect_to "/users/#{current_user.id}"
    # end
    @follows = Follow.all
    #get posts that have user id = user.following
    @feed_posts = []
    @current_user.following.each do |followed|
      @feed_posts.append(Post.where(user_id: followed.id))
    end

    # get current user if logged in
    # if profile is same as user, edit profile
    # if profile is different, have follow button
    # show feed
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
      params.require(:user).permit(:username, :lastname, :stream_link, :description, :timezone_code,:password,:password_confirmation)
    end
end
