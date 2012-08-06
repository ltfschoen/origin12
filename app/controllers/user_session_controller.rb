class UserSessionController < ApplicationController

  before_filter :require_no_user, only: [ :new, :create ]

  before_filter :require_user, only: [ :destroy ]

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if user_session.save
        format.html { redirect_back_or_default root_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    respond_to do |format|
      current_user_session.destroy
      format.html { redirect_to root_path }
    end
  end

private

  helper_method :user_session

  def user_session
    @user_session ||= UserSession.new(params[:user_session])
  end

end

