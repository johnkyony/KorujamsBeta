class DevelopersController < ApplicationController
    layout "paper_kit"
    before_action :authenticate_user!
  def index
   @features = ProjectMilestone.all
   end
end
