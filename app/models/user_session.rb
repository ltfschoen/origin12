class UserSession < Authlogic::Session::Base

  extend ActiveModel::Naming

  logout_on_timeout true

  generalize_credentials_error_messages "Login and password are invalid"

  InactivityTimeout = 20.minutes

  remember_me_for 4.weeks

  private

  def enabled?
    if attempted_record.present? && attempted_record.disabled?
      errors.add(:base, I18n.t("error_messages.not_enabled", :default => "account is not enabled"))
    end
  end

end
