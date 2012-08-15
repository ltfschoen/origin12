class UsersController < ApplicationController

  before_filter :require_user, only: [ :edit, :update ]

  before_filter :require_no_user, only: [ :new, :create ]

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

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if user.update_attributes(params[:user])
        flash[:success] = "Account details updated"
        format.html { redirect_to root_path }
      else
        format.html { render action => 'edit' }
      end
    end
  end

private

  helper_method :user

  def user
    @user ||= begin
      current_user || begin
        User.new(params[:user]) do |user|
          user.employee = employee
          user.email = params[:email] if user.email.blank?
        end
      end
    end
  end

  def employee
    @employee ||= begin
      email = params[:user] && params[:user][:email] || params[:email]
      Employee.find_by_email(email) if email
    end
  end

end
