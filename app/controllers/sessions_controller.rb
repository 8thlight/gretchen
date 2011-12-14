class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if user.save
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
