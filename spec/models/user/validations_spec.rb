require 'spec_helper'

describe User, "validations" do
  it "is valid if have everything OK" do
    user = User.create(:name => "Julio",
                    :email => "saitodisse@gmail.com")
    user.password = "abcdefghijklmnoprstuvxz"
    user.should be_valid
  end

  it "requires name" do
    user = User.create(:name => nil,
                    :email => "saitodisse@gmail.com")
    user.password_hash = "abcdefghijklmnoprstuvxz"
    user.should_not be_valid
  end

  it "requires email and to be valid" do
    user = User.create(:email => nil)
    expect(subject).to have(2).errors_on(:email)
  end

  it "email cannot be invalid" do
    user = User.create(:email => "a@a")
    expect(user).to have(1).errors_on(:email)
  end

  it "email can be valid" do
    user = User.create(:email => "saitodisse@gmail.com")
    expect(user).to have(:no).errors_on(:email)
  end

  it "requires password" do
    user = User.create
    expect(user).to have(1).error_on(:password)
  end

  it "password and password_confirmation must be the same" do
    user = User.create(:password => "123", :password_confirmation => "321")
    expect(user).to have(1).error_on(:password)
  end

  it "password and password_confirmation are the same" do
    user = User.create(:password => "123", :password_confirmation => "123")
    expect(user).to have(:no).error_on(:password)
  end
end
