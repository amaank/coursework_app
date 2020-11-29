class BookingsController < ApplicationController
  before_action :get_vehicle
  before_action :set_booking, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_booking_user

  # GET /vehicles/1/bookings/new
  def new
    @booking = @vehicle.bookings.build
  end

  # GET /vehicles/1/bookings/1/edit
  def edit
  end

  # POST /vehicles/1/bookings
  # POST /vehicles/1/bookings.json
  def create
    @booking = @vehicle.bookings.build(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to vehicle_path(@vehicle), notice: I18n.t('bookings.create.success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /vehicles/1/bookings/1
  # PATCH/PUT /vehicles/1/bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to vehicle_path(@vehicle), notice: I18n.t('bookings.update.success') }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1/bookings/1
  # DELETE /vehicles/1/bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_path(@vehicle), notice: I18n.t('bookings.destroy.success') }
      format.js { flash.now[:notice] = I18n.t('bookings.destroy.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_vehicle
      @vehicle = Vehicle.find(params[:vehicle_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = @vehicle.bookings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:space_id, :vehicle_id, :cost_type_id, :date)
    end

    # Prevent action if it relates to a different user's booking.
    def check_booking_user
      redirect_to root_path unless @vehicle.user == current_user
    end
end
