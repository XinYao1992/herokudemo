class LoginController < ApplicationController
  before_filter :administrator
  def index
    @total_locations = Location.count
  end

  protected
    def administrator
      unless Administrator.find_by_id(session[:id]) && Customer.find_by_id(session[:id])
        redirect_to
    end
end
