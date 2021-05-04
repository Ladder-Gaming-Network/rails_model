class InterestsController < ApplicationController
  before_action :set_interest, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:new]

  # GET /interests or /interests.json
  def index
    @interests = Interest.all
    if !admin?
      flash[:danger]="Only the Admin can see that!"
      redirect_to ""
    end
  end

  # GET /interests/1 or /interests/1.json
  def show
  end

  # GET /interests/new
  def new
    @interest = Interest.new
  end

  # GET /interests/1/edit
  def edit
  end

  # POST /interests or /interests.json
  def create
    @interest_params=interest_params
    @interest_params["user_id"]=current_user.id
    @interest = Interest.new(@interest_params)

    if @interest.save
      redirect_to "/users/#{current_user.id}"
    else 
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @interest.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /interests/1 or /interests/1.json
  def update
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to @interest, notice: "Interest was successfully updated." }
        format.json { render :show, status: :ok, location: @interest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interests/1 or /interests/1.json
  def destroy
    @interest.destroy
    respond_to do |format|
      format.html { redirect_to interests_url, notice: "Interest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interest_params
      params.require(:interest).permit(:user_id, :interest)
    end
end
