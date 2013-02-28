require 'spec_helper'

describe PasswordEncryptor, "validations" do
  it "ensure encryptor injects bcrypt" do
    expect(PasswordEncryptor.encryptor).to eql(BCrypt::Password)
  end

  let(:encryptor) { mock("encryptor") }

  context "encrypting passwords" do
    before do
      PasswordEncryptor.stub :encryptor => encryptor
    end

    it "create receives the password as a parameter" do
      encryptor.should_receive(:create).with("one_password")
      PasswordEncryptor.encrypt("one_password")
    end
  end

  context "validating password" do
    before do
      PasswordEncryptor.stub :encryptor => encryptor
    end

    it "valid? receives the password_hash to instantiates encryptor" do
      encryptor.should_receive(:new).with("some hash")
      PasswordEncryptor.valid?("some hash", "one_password")
    end

    it "validation works - valid" do
      encryptor.stub :new => "one_password"
      expect(PasswordEncryptor).to be_valid("some_hash", "one_password")
    end

    it "validation works - invalid" do
      encryptor.stub :new => "one_password"
      expect(PasswordEncryptor).not_to be_valid("some_hash", "one_password2")
    end
  end

end
