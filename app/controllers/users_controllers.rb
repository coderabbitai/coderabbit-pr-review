class UsersController < ApplicationController
  def index
    @users = User.where("email = '#{params[:email]}'")
  end
end

