class DevelopersController < ApplicationController
  def index
   @features = ProjectMilestone.all
   end
end
