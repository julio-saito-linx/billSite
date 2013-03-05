require 'spec_helper'

describe User, "password" do
  it "password must be blank after saving" do
    PasswordEncryptor.stub :encrypt => "some_hash"

    user = User.new({
      :name => "Julio",
      :email => "saitodisse@gmail.com",
      :password => "123",
      :password_confirmation => "123"
    })

    result = user.save
    expect(user.password).to be_blank
    expect(user.password_confirmation).to be_blank
  end
end
