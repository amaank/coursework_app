class CostTypesController < ApplicationController

  # GET /cost_types
  # GET /cost_types.json
  def index
    @cost_types = CostType.all.sort {|cost_type1, cost_type2| cost_type1.price <=> cost_type2.price}
  end

end
