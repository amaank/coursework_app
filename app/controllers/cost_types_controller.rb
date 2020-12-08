class CostTypesController < ApplicationController
  before_action :authenticate_user!

  # GET /cost_types
  # GET /cost_types.json
  def index
    # Sort the objects to be displayed in ascending order, by value of price attribute.
    @cost_types = CostType.all.sort {|cost_type1, cost_type2| cost_type1.price <=> cost_type2.price}
  end

end
