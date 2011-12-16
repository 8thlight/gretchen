class UsersController < ApplicationController

  before_filter :check_user, :except => [:index, :new, :create]

  def index
    if current_user.admin? == false
      redirect_to current_user, :notice => "Unauthorized Access"
    end
    @users = User.all
  end

  def show
    @vacation = Vacation.new
    @dates = current_user.vacations
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User Created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash.now[:error] = "Invalid input"
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user.update_attribute(:deleted, true)
      flash[:success] = "Deleted #{@user.name}"
      redirect_to "/users"
    else
      flash.now[:error] = "Failed to Delete"
      render 'index'
    end
  end

  def activate
    @user = User.find_by_id(params[:user_id])
    if @user.update_attribute(:deleted, false)
      flash[:success] = "Activated #{@user.name}"
      redirect_to "/users"
    else
      flash[:error] = "Failed to Delete"
      render 'index'
    end
  end

  private

    def check_user
      @user = User.find(params[:id]) if params[:id]
      if !current_user
        render '/'
      elsif current_user.admin? == false && current_user.id != @user.id
        redirect_to current_user, :notice => "Unauthorized Access"
      end
    end
end

