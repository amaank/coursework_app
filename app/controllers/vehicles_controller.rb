class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_vehicle_user, only: [:show, :edit, :update, :destroy]

  # GET /vehicles
  # GET /vehicles.json
  def index
    # Sort the objects to be displayed, by value of registration_number attribute (alphabetical order).
    @vehicles = Vehicle.user_vehicles(current_user).sort {|vehicle1, vehicle2| vehicle1.registration_number <=> vehicle2.registration_number}
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    # Set the associated user object to be the currently signed-in user.
    @vehicle.user = current_user

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: I18n.t('vehicles.create.success') }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: I18n.t('vehicles.update.success') }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: I18n.t('vehicles.destroy.success') }
      # Flash an appropriate notice in response to an AJAX request sent when performing destroy action.
      format.js { flash.now[:notice] = I18n.t('vehicles.destroy.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:registration_number, :make, :model, :colour)
    end

    # Prevent action if it relates to a different user's vehicle.
    def check_vehicle_user
      redirect_to root_path unless @vehicle.user == current_user
    end
end
