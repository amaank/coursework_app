class CostTypesController < ApplicationController

  # GET /cost_types
  # GET /cost_types.json
  def index
    @cost_types = CostType.all
  end

end
