class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_reader :password

  validates_presence_of :name, :password, :password_confirmation
  validates_format_of :email, :with => /^((?:(?:(?:\w[\.\-\+]?)*)\w)+)\@((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,6})$/
  validates_confirmation_of :password

  def password=(password)
    self.password_hash = PasswordEncryptor.encrypt(password)
    @password = password
  end

end
