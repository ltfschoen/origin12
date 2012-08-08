class UsersController < ApplicationController

  before_filter :require_no_user

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if user.save
        current_company current_user.default_company
        format.html { redirect_to root_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

private

  helper_method :user

  def user
    @user ||= User.new(params[:user])
  end

end
