class SessionsController < ApplicationController
  #before_filter :authorize
  #skip_before_filter :authorize, only :new

  def new
  end

  def create
    if customer = Customer.authenticate(params[:name], params[:password])#password
      session[:customer_id] = customer.id
      if customer.category == 1
        redirect_to admin_url
      else
        redirect_to welcome_url
      end
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to customer_url, :notice => "Logged out"
  end

  #protected
  #def authorize
    #unless Customer.find_by_id(params[:name])
      #redirect_to login_url, :notice => "Please log in"
    #end
  #end
end
