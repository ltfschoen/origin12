class UserSessionController < ApplicationController

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if user_session.save
        current_company current_user.default_company
        format.html { redirect_back_or_default root_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    respond_to do |format|
      current_user_session.destroy if current_user_session
      format.html { redirect_to new_session_path }
    end
  end

private

  helper_method :user_session

  def user_session
    @user_session ||= UserSession.new(params[:user_session])
  end

end

