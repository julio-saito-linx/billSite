require 'spec_helper'

describe User, "password hashing" do
  subject(:user) { User.new }



  it "generates hash" do
    # mock
    PasswordEncryptor.should_receive(:encrypt).with("some_password")
    user.password = "some_password"
  end

  it "sets hash" do
    # stub
    PasswordEncryptor.stub :encrypt => "some_hash"
    user.password = "some_password"

    expect(user.password_hash).to eql("some_hash")
  end

  it "sets password" do
    PasswordEncryptor.stub :encrypt
    user.password = "some_password"

    expect(user.password).to eql("some_password")
  end
end
