class DevelopersController < ApplicationController
  def index
   @features = ProjectMilestone.all.limit(5)
  end
end
