class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # check valid email
  def valid_email
    name = params[:fieldValue]
    if name.strip == ""
      render :json => { :available => false }
      return
    end
    user = User.where(:email => name.downcase).first
    if user.blank?
      render :json =>  ["user_email", false , ""]
    else
      render :json =>  ["user_email", true , ""]
    end
  end 
  
  private 
  def after_sign_in_path_for(resource)
    if resource.is_a? User
      stored_location_for(resource) || passports_path       
    end
  end
      
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end
end
