class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth
      puts auth
      user = User.find_by_name_and_email(auth["info"]["name"], auth["info"]["email"])
      update = {:uid => auth["uid"], :provider => auth["provider"], :token => auth["credentials"]["token"], :refresh_token => auth["credentials"]["refresh_token"] }
    end
    if !user.nil? && user.email =="san.y4ku@gmail.com"
      user[:token] = auth['credentials']['token']
      user[:refresh_token] = auth["credentials"]["refresh_token"]
      user.save(:validate => false)
      session[:user_id] = user.id
      redirect_to '/users'
    elsif !user.nil? && user.update_attributes(update) && !user.deleted?
      session[:user_id] = user.id
      redirect_to "/calendar"
    else
      redirect_to root_url, :notice => "You must be an 8th Light Craftsman to see this project"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
