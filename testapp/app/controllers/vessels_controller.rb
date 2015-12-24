class VesselsController < ApplicationController
  before_action :set_vessel, only: [:show, :edit, :update, :destroy]

  # GET /vessels
  # GET /vessels.json
  def index
    @vessels = Vessel.all
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit
    @title = @vessel.title
    @description = @vessel.description
  end

  # POST /vessels
  # POST /vessels.json
  def create
    @vessel = Vessel.new(vessel_params)
    @ip = request.remote_ip
    respond_to do |format|
      if @vessel.save
        if (current_admin.nil?)
          NotificationMailer.new_post(@ip, @vessel).deliver_now()
        end
        format.html { redirect_to vessels_url, notice: 'Vessel was successfully created.' }
        format.json { render :show, status: :created, location: @vessel }
      else
        format.html { render :new }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vessels/1
  # PATCH/PUT /vessels/1.json
  def update
    @ip = request.remote_ip
    @old_vessel = @vessel.as_json()
    respond_to do |format|
      if @vessel.update(vessel_params)
        @old_vessel["updated_at"] = @vessel.updated_at
        if (current_admin.nil?)
          NotificationMailer.edit_post(@ip, @vessel, @old_vessel, vessel_params).deliver_now()
        end
        format.html { redirect_to vessels_url, notice: 'Vessel was successfully updated.' }
        format.json { render :show, status: :ok, location: @vessel }
      else
        format.html { render :edit }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vessels/1
  # DELETE /vessels/1.json
  def destroy
    @vessel.destroy
    respond_to do |format|
      format.html { redirect_to vessels_url, notice: 'Vessel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vessel
      @vessel = Vessel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vessel_params
      params.require(:vessel).permit(:title, :description, :daily_price, :fee_pc)
    end
end
