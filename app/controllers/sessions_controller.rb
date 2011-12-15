class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_name_and_email(auth["info"]["name"], auth["info"]["email"]) #|| User.create_with_omniauth(auth)
    update = {:uid => auth["uid"], :provider => auth["provider"] }
    if user.email =="san.y4ku@gmail.com"
      session[:user_id] = user.id
      redirect_to '/calendar'
    
      elsif user.update_attributes(update) && !user.deleted?
        session[:user_id] = user.id
        redirect_to '/calendar'
      else
        redirect_to root_url, :notice => "You must be an 8th Light Craftsman to see this project"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
