class User < ActiveRecord::Base
  attr_accessible :email, :name, :password,:password_confirmation
  attr_accessor :password

  validates_presence_of :email, :name, :password
  validates_format_of :email, :with => /^((?:(?:(?:\w[\.\-\+]?)*)\w)+)\@((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,6})$/

  validates_confirmation_of :password
end
