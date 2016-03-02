class AdminController < ApplicationController
  def index
    @total_locations = Location.count
  end

end
