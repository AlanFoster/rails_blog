class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  def encrypt_password
    return if password.blank?

    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    self.password = nil
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && expected_password?(user, password)
      user
    end
  end

  def self.expected_password?(user, password)
    expected_hash = user.password_hash
    actual_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
    expected_hash == actual_hash
  end
end
