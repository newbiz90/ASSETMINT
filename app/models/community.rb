# app/models/community.rb
class Community < ApplicationRecord
  # This method now accepts an email parameter to fetch a specific user
  def find_user_by_email(email)
    User.find_by(email: email) # Returns a single user or nil if not found
  end
end
