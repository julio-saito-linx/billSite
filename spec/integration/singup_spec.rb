# encoding: UTF-8
require 'spec_helper'

describe "SingUp" do
  context "with valid data" do
    before do
      visit root_path
      click_link I18n.t("menu.new_user")

      fill_in I18n.t("labels.user.name"), :with => "Julio Saito"
      fill_in I18n.t("labels.user.email"), :with => "saitodisse@gmail.com"
      fill_in I18n.t("labels.user.password"), :with => "123456"
      fill_in I18n.t("labels.user.password_confirmation"), :with => "123456"

      click_button I18n.t("labels.user.create_user")
    end

    it "redirect to created page" do
      expect(current_path).to eql(users_created_path)
    end

    it "displays successful message" do
      expect(page).to have_content(I18n.t("labels.user.user_created"))
    end
  end

  context "with invalid data" do
    before do
      visit root_path
      click_link I18n.t("menu.new_user")
      click_button I18n.t("labels.user.create_user")
    end

    it "do not redirect to created page" do
      expect(current_path).to eql(users_new_path)
    end

    it "must show validations errors title" do
      expect(page).to have_content(I18n.t("form.errors"))
    end

    it "do not displays successful message" do
      expect(page).to_not have_content(I18n.t("labels.user.user_created"))
    end
  end
end
