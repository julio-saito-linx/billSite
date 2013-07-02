# encoding: UTF-8
require 'spec_helper'

describe "Login" do
  context "with valid data" do
    before do
      User.create({
        :name => "Julio Saito",
        :email => "saitodisse@gmail.com",
        :password => "123456",
        :password_confirmation => "123456"
      })

      visit root_path
      click_link I18n.t("menu.login")

      fill_in I18n.t("labels.user.email"), :with => "saitodisse@gmail.com"
      fill_in I18n.t("labels.user.password"), :with => "123456"

      click_button I18n.t("labels.login.submit_login")
    end

    it "redirect to root path" do
      expect(current_path).to eql(root_path)
    end

    it "hide menu.new_user link" do
      expect(page).to_not have_content(I18n.t("menu.new_user"))
    end

    it "hide menu.login link" do
      expect(page).to_not have_content(I18n.t("menu.login"))
    end

    it "shows user name" do
      u = User.where(:email => "saitodisse@gmail.com").first
      expect(page).to have_content(u.name)
    end
  end

  context "with invalid data" do
    before do
      visit root_path
      click_link I18n.t("menu.login")

      fill_in I18n.t("labels.user.email"), :with => "saitodisse@gmail.com"
      fill_in I18n.t("labels.user.password"), :with => "WRONG PASSWORD"

      click_button I18n.t("labels.login.submit_login")
    end
  end
end
