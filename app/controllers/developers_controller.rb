class DevelopersController < ApplicationController
    layout "paper_kit"
  def index
   @features = ProjectMilestone.all
   end
end
