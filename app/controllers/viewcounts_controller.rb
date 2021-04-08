class ViewcountsController < ApplicationController
  before_action :set_viewcount, only: %i[ show edit update destroy ]

  # GET /viewcounts or /viewcounts.json
  def index
    @viewcounts = Viewcount.all
    if !admin?
      flash[:danger]="Only the Admin can see that!"
      redirect_to ""
    end
  end

  # GET /viewcounts/1 or /viewcounts/1.json
  def show
  end

  # GET /viewcounts/new
  def new
    @viewcount = Viewcount.new
  end

  # GET /viewcounts/1/edit
  def edit
  end

  # POST /viewcounts or /viewcounts.json
  def create
    @viewcount = Viewcount.new(viewcount_params)

    respond_to do |format|
      if @viewcount.save
        format.html { redirect_to @viewcount, notice: "Viewcount was successfully created." }
        format.json { render :show, status: :created, location: @viewcount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @viewcount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /viewcounts/1 or /viewcounts/1.json
  def update
    respond_to do |format|
      if @viewcount.update(viewcount_params)
        format.html { redirect_to @viewcount, notice: "Viewcount was successfully updated." }
        format.json { render :show, status: :ok, location: @viewcount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @viewcount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /viewcounts/1 or /viewcounts/1.json
  def destroy
    @viewcount.destroy
    respond_to do |format|
      format.html { redirect_to viewcounts_url, notice: "Viewcount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viewcount
      @viewcount = Viewcount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def viewcount_params
      params.require(:viewcount).permit(:stream_id, :viewers, :created_at)
    end
end
