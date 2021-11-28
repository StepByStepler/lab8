class User < ApplicationRecord
  has_secure_password

  # def has_password?(submitted_password)
  #   p "password = #{password_digest}"
  #   p "hash = #{BCrypt::Password.create(submitted_password)}"
  #   p "new = #{BCrypt::Password.new(submitted_password)}"
  #   p "result = #{BCrypt::Password.new(submitted_password) == password_digest}"
  #   BCrypt::Password.new(submitted_password) == password_digest
  # end
  #
  def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    return nil if user.nil?
    return user if user.authenticate(submitted_password)
  end
end
