class UserSession < ApplicationController

  before_filter :require_no_user

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      if create_user_and_log_in
        format.html { redirect_to root_path }
      else
        format.html { render action: 'show' }
      end
    end
  end

  def create
    respond_to do |format|
      if user_session.save
        format.html { redirect_back_or_default(root_path) }
      else
        @user = User.new({ :invitation_code => params[:invitation_code] })
        format.html { render :action => 'show' }
      end
    end
  end

end

