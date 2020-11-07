class SpacesController < ApplicationController

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
  end

end
