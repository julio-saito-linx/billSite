class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_reader :password

  after_save :erase_password

  validates_presence_of :name
  validates_format_of :email, :with => /^((?:(?:(?:\w[\.\-\+]?)*)\w)+)\@((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,6})$/

  validates_presence_of :password, :password_confirmation, :if => :validates_password?
  validates_confirmation_of :password, :if => :validates_password?

  def password=(password)
    self.password_hash = PasswordEncryptor.encrypt(password)
    @validate_password = true
    @password = password
  end


  private
    def erase_password
      self.password = nil
      self.password_confirmation = nil
      @validate_password = false
    end

    def validates_password?
      new_record? || @validate_password
    end

end
