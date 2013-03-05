require 'spec_helper'

describe User, "validations" do
  before(:each) do
    PasswordEncryptor.stub :encrypt => "some_hash"
  end

  it "is valid if have everything OK" do
    user = User.new({
      :name => "Julio",
      :email => "saitodisse@gmail.com",
      :password => "some_password",
      :password_confirmation => "some_password"
      })

    user.should be_valid
  end

  it "requires name, email and password" do
    user = User.new
    expect(user).to have(1).errors_on(:name)
    expect(user).to have(1).errors_on(:email)
    expect(user).to have(1).errors_on(:password)
    expect(user).to have(1).errors_on(:password_confirmation)
  end

  it "check if email is invalid" do
    user = User.create(:email => "a@a")
    expect(user).to have(1).errors_on(:email)
  end

  it "check if email is valid" do
    user = User.create(:email => "saitodisse@gmail.com")
    expect(user).to have(:no).errors_on(:email)
  end

  it "password and password_confirmation must match" do
    user = User.create(:password => "123", :password_confirmation => "321")
    expect(user).to have(1).error_on(:password)
  end

  it "password and password_confirmation do match" do
    user = User.create(:password => "123", :password_confirmation => "123")
    expect(user).to have(:no).error_on(:password)
  end

  it "creates password hash when password is given" do
    user = User.new(:password => "123")
    expect(user.password_hash).not_to be_blank
  end

  context "when updating" do
    let!(:user){
      User.create!({
        :name => "Julio",
        :email => "saitodisse@gmail.com",
        :password => "some_password",
        :password_confirmation => "some_password"
      })
    }

    it "password is not mandatory to update" do
      user = User.first
      user.valid?
      expect(user).to be_valid
    end
  end
end
