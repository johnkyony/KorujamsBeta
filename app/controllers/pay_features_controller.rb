class PayFeaturesController < ApplicationController
  def new
    @feature = ProjectMilestone.find_by_id(params[:id])
  end

  def create
  end
end
