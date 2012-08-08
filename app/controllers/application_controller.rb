require 'exceptions/current_company_error'

class ApplicationController < ActionController::Base

  protect_from_forgery

protected

  helper_method \
    :current_company,
    :current_employee,
    :current_user,
    :current_user_session

  def current_user_session
    @current_user_session ||= begin
      @current_user_session = UserSession.find
    end
  end

  def current_user
    @current_user ||= begin
      current_user_session && current_user_session.user
    end
  end

  def current_employee
    @current_employee ||= begin
      current_user && current_user.employee
    end
  end

  def current_company(company = nil)
    if company
      @current_company = company
      session[:current_company_id] = company[:id]
    else
      @current_company ||= begin
        if session[:current_company_id].present?
          current_user.companies.find(session[:current_company_id])
        else
          raise CurrentCompanyError
        end
      end
    end
  end

protected

  def require_user
    return true if current_user
    store_location
    redirect_to new_session_path
    false
  end

  def require_no_user
    return true unless current_user
    store_location
    flash[:notice] = "You must be logged out to access this page"
    redirect_to session_path, method: 'delete'
    false
  end

  def redirect_back_or_default(default)
    redirect_to session[:return_to_path] || default
    session[:return_to_path] = nil
  end

  def store_location
    session[:return_to_path] = request.fullpath
  end

end
