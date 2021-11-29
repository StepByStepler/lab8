class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :name

  def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    return nil if user.nil?
    return user if user.authenticate(submitted_password)
  end
end
