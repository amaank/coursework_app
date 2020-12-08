class SpacesController < ApplicationController
  before_action :authenticate_user!

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
    # If a date has been received from a form submission.
    if space_params[:date]
      begin
        # Attempt to parse the value provided as a date.
        date = Date.parse(space_params[:date])
        # Set the value of the displayed date, depending on whether the chosen date is in the required range.
        check_date_range(date)
      rescue ArgumentError
        # If the given value is invalid (cannot be parsed as a date), set it to the default.
        set_default_date()
        # Flash an alert to tell the user that they chose an invalid date.
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.default')
      end
    else
      # When no date has been explicitly chosen (for instance, if form not used), set it to the default.
      set_default_date()
    end
  end

  private
    def set_default_date
      # Set the displayed date to be today.
      @chosen_date = Date.today
      # And clear the date parameter.
      params.delete(:date)
    end

    # Check that a given date is within the required range.
    def check_date_range(date)
      # If the date is in the past.
      if date < Date.today
        # Set the displayed date to the default.
        set_default_date()
        # Flash alert to tell the user that the date was invalid as it was in the past.
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.too_early')
      # If the date is more than 7 days ahead.
      elsif date > (Date.today + 7.days)
        # Set the displayed date to the default.
        set_default_date()
        # Flash alert to tell the user that the date was invalid as it was too far into the future.
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.too_late')
      else
        # If the chosen date is valid, set it as the current displayed date.
        @chosen_date = date
      end
    end

    # Only allow a list of trusted parameters through.
    def space_params
      params.permit(:date)
    end

end
