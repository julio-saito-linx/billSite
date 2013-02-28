require "bcrypt"

class PasswordEncryptor
  def self.encryptor
    BCrypt::Password
  end

  def self.encrypt(password)
    password_hash = encryptor.create(password)
    return password_hash
  end

  def self.valid?(password_hash, password_passed)
    password = encryptor.new(password_hash)
    password == password_passed
  end
end
