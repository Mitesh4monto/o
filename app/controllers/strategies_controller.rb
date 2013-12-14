class StrategiesController < ApplicationController

  def mine
    @related_hals = Hal.get_hals_related_to_strategy(current_user.strategy)
  end

  
  def mine_details
    @related_hals = Hal.get_hals_related_to_strategy(current_user.strategy)
      @activity = Activity.find params[:id]
  end
end
