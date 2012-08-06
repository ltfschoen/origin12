class UserSession < Authlogic::Session::Base

  INACTIVITY_TIMEOUT = 20.minutes

  extend ActiveModel::Naming

  logout_on_timeout true
  remember_me_for 4.weeks
  generalize_credentials_error_messages "Login and password are invalid"

  private

  def enabled?
    if attempted_record.present? && attempted_record.disabled?
      errors.add(:base, I18n.t("error_messages.not_enabled", :default => "account is not enabled"))
    end
  end

end
