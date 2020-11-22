class SpacesController < ApplicationController

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
    # If a date has been received from a form submission.
    if params[:date]
      begin
        date = Date.parse(params[:date])
        # Set the value of the displayed date, depending on whether the chosen date is in the required range.
        check_date_range(date)
      rescue ArgumentError
        # If the given date is invalid, set it to the default.
        set_default_date()
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.default')
      end
    else
      # When no date has been explicitly chosen, set it to the default.
      set_default_date()
    end
  end

  private
    # Set the displayed date to be today, and clear the date parameter.
    def set_default_date
      @chosen_date = Date.today
      params.delete(:date)
    end

    # Check that a given date is within the required range.
    def check_date_range(date)
      if date < Date.today
        set_default_date()
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.too_small')
      elsif date > (Date.today + 7.days)
        set_default_date()
        flash.now[:alert] = I18n.t('spaces.index.invalid_date.too_large')
      else
        # If the chosen date is valid, set it as the current displayed date.
        @chosen_date = date
      end
    end

end
