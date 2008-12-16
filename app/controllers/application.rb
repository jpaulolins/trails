# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  class AccessDenied < StandardError; end
  
  helper :all # include all helpers, all the time
#  layout :select_layout
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '64494148a3271b41522328f8ab71fb2d'
  
  private
  
  def select_layout
    logged_in? ? "logged" : "application"
  end
  
  def catch_errors
    begin
      yield
    rescue AccessDenied
      flash[:error] = "You do not have access to that area."
      redirect_to '/'
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Sorry, can't find that record."
      redirect_to '/'
    end
  end
  
end
