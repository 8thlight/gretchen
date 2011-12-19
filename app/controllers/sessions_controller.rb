class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth 
      puts auth
    else 
      puts "SOMTHING JUST WENT TERRIBLY WRONG!"
    end
    user = User.find_by_name_and_email(auth["info"]["name"], auth["info"]["email"]) #|| User.create_with_omniauth(auth)
    update = {:uid => auth["uid"], :provider => auth["provider"], :token => auth["credentials"]["token"] }
      if !user.nil? && user.email =="san.y4ku@gmail.com"
        puts user[:token] = auth['credentials']['token']
        user.save(:validate => false)
        session[:user_id] = user.id
        redirect_to '/users'
      elsif !user.nil? && user.update_attributes(update) && !user.deleted?
        session[:user_id] = user.id
        redirect_to "/users/#{user.id}"
      else
        redirect_to root_url, :notice => "You must be an 8th Light Craftsman to see this project"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
