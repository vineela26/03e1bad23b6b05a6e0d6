class Api::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users.limit(3).offset(params["offset"])
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(firstName: params[:firstName], lastName: params[:lastName], email: params[:email])
    @user.save
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    @user.update(firstName: params[:firstName], lastName: params[:lastName], email: params[:email])
    render json: @user

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: User.all
  end

  def dynamic_search
    users = []
   @users = User.where('firstName LIKE :str OR lastName LIKE :str OR email LIKE :str', str: "%#{params["input"]}%")
   @users.each do |user|
     users << "#{user.firstName} #{user.lastName}"
   end
   render json: users
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName,:email)
  end

end
