class AdminsController < ApplicationController
  layout "paper_kit"
  before_action :authenticate_user!
  def index
  end
end
