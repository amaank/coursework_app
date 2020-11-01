class SpacesController < ApplicationController
  before_action :set_space, only: [:show]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end
end
