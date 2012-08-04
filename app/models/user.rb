class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.logged_in_timeout UserSession::InactivityTimeout
  end

  attr_accessible :email

  has_one :employee

end
